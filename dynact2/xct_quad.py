import os
import sys
import argparse

import numpy as np
import SimpleITK as sitk
import math

from timeit import default_timer as timer 

from transform import resampleFullExtent
from bounding_box_quad import bounding_box

def main():
    main_start = timer()

    parser = argparse.ArgumentParser()
    parser.add_argument("xct_seg_path", type=str, help="Bone segmentation")
    parser.add_argument("xct_js_path", type=str, help="Joint surface segmentation")
    parser.add_argument("slice_axis", type=int, default=1, help="Z is axial or Y is axial (default=True is Z is axial)")

    args = parser.parse_args()
    xct_seg_path = args.xct_seg_path
    xct_js_path = args.xct_js_path
    slice_axis = args.slice_axis
    
    #---------------------------------------------------#
    # Read in images
    #---------------------------------------------------#
    xct_seg_img = sitk.ReadImage(xct_seg_path, sitk.sitkUInt8)
    xct_js_img = sitk.ReadImage(xct_js_path, sitk.sitkUInt8)

    # Resample JS to bone mask
    resampled_js_img = sitk.BinaryDilate(xct_js_img, (9,9,9))
    resampled_js_img = sitk.Resample(xct_js_img, xct_seg_img, interpolator=sitk.sitkNearestNeighbor)
    sitk.WriteImage(resampled_js_img, os.path.splitext(xct_js_path)[0] + "_DILATE.nii")

    # Get PAs of JS
    shape_stats = sitk.LabelShapeStatisticsImageFilter()
    shape_stats.SetComputeOrientedBoundingBox(True)
    shape_stats.Execute(resampled_js_img)
    
    shape_stats2 = sitk.LabelShapeStatisticsImageFilter()
    shape_stats2.SetComputeOrientedBoundingBox(True)
    shape_stats2.Execute(xct_seg_img)

    aligned_image_spacing = xct_seg_img.GetSpacing()
    aligned_image_origin = shape_stats2.GetOrientedBoundingBoxOrigin(1)
    aligned_image_size = [int(math.ceil(shape_stats2.GetOrientedBoundingBoxSize(1)[i] / aligned_image_spacing[i])) for i in range(3)]
    direction_mat = shape_stats.GetOrientedBoundingBoxDirection(1)

    # The order of the columns in the rotation matrix from the oriented bounding box changes with the shape
    # So depending on the shape/image, we may need to shuffle the X, Y, Z axes
    # This mostly affects the XCT MC1 bones. If you change the order, change if in both places in this script to match
    aligned_image_direction = [
        direction_mat[1],
        direction_mat[4],
        direction_mat[7],
        direction_mat[0],
        direction_mat[3],
        direction_mat[6],
        direction_mat[2],
        direction_mat[5],
        direction_mat[8],
    ]

    resampler = sitk.ResampleImageFilter()
    resampler.SetInterpolator(sitk.sitkNearestNeighbor)
    resampler.SetOutputDirection(aligned_image_direction)
    resampler.SetOutputOrigin(aligned_image_origin)
    resampler.SetOutputSpacing(aligned_image_spacing)
    resampler.SetSize(xct_seg_img.GetSize())               
    obb_img = resampler.Execute(xct_seg_img)

    pad = sitk.ConstantPad(obb_img, [512,512,512], [512,512,512], 0)
    obb_img = sitk.Resample(xct_seg_img, pad, interpolator=sitk.sitkNearestNeighbor)

    obb_img = sitk.Resample(xct_seg_img, obb_img, interpolator=sitk.sitkNearestNeighbor)
    min_val = int(np.max(sitk.GetArrayFromImage(obb_img)))
    obb_img = bounding_box(obb_img, min_val, min_val)

    # Change the image axes order so that we have a nice display
    obb_img = sitk.PermuteAxes(obb_img, [2, 1, 0])
    sitk.WriteImage(obb_img, os.path.splitext(xct_seg_path)[0] + "_ROTATED.nii")

    #---------------------------------------------------#
    # Separate into quadrants
    #---------------------------------------------------#
    # min_val = int(np.max(sitk.GetArrayFromImage(obb_img)))
    # bb_xct_img = bounding_box(obb_img, min_val, min_val)
    # sitk.WriteImage(bb_xct_img, os.path.splitext(xct_seg_path)[0] + "_ROTATED_BB.nii")

    # resampled_js_img = sitk.BinaryDilate(xct_js_img, (9,9,9))
    # resampled_js_img = sitk.Resample(resampled_js_img, bb_xct_img, interpolator=sitk.sitkNearestNeighbor)
    resampled_js_img = sitk.Resample(xct_js_img, obb_img, interpolator=sitk.sitkNearestNeighbor)
    # bb_js_img = bounding_box(resampled_js_img, 1, 4)
    # sitk.WriteImage(bb_js_img, os.path.splitext(xct_seg_path)[0] + "_JS_BB.nii")

    # For some scans, we need to slice images in the Y direction
    # Most of the time the Z direction works though
    if slice_axis:
        # dilated_js = sitk.BinaryDilate(bb_js_img, (0, 0, 2*int(obb_img.GetSize()[2])+1))
        mask = sitk.Image(obb_img.GetSize(), sitk.sitkUInt8)
        mask.SetOrigin(obb_img.GetOrigin())
        mask.SetDirection(obb_img.GetDirection())
        mask.SetSpacing(obb_img.GetSpacing())
        mask[:] = 0
        mask += resampled_js_img

        stats_filter = sitk.LabelShapeStatisticsImageFilter()
        stats_filter.Execute(mask)
    
        # Get the bounding box. Returns an array in the format:
        # [x_start, y_start, z_start, x_size, y_size, z_size]
        bounding_box_dim = np.array(stats_filter.GetBoundingBox(1))
        x_start = bounding_box_dim[0]
        y_start = bounding_box_dim[1]
        z_start = bounding_box_dim[2]
        x_end = x_start + bounding_box_dim[3]
        y_end = y_start + bounding_box_dim[4]
        z_end = z_start + bounding_box_dim[5]

        mask[x_start:x_end, y_start:y_end, 0:obb_img.GetSize()[2]] = 1
        dilated_js = mask
    else:
        dilated_js = sitk.BinaryDilate(resampled_js_img, (0, 2*int(obb_img.GetSize()[2])+1, 0))

    # dilated_js = sitk.Resample(dilated_js, obb_img, interpolator=sitk.sitkNearestNeighbor)
    # dilated_js[:] = 1
    dilated_js2 = sitk.ConstantPad(dilated_js, [1,1,1], [1,1,1], 0)
    sitk.WriteImage(dilated_js2, os.path.splitext(xct_seg_path)[0] + "_JS_BB_DILATE.nii")
    
    masked_bone = sitk.Mask(obb_img, dilated_js)
    min_val = int(np.max(sitk.GetArrayFromImage(masked_bone)))
    bb_masked_bone = bounding_box(masked_bone, min_val, min_val)
    sitk.WriteImage(bb_masked_bone, os.path.splitext(xct_seg_path)[0] + "_ROTATED_BB_MASKED.nii")

    size_x = bb_masked_bone.GetSize()[0]
    size_y = bb_masked_bone.GetSize()[1]
    size_z = bb_masked_bone.GetSize()[2]

    # For the MC1, we only want the top 25% of the bone for vBMD
    # Use the WBCT scan of the MC1 to calculate the length of the MC1
    if "mc1" in xct_seg_path.lower():
        wbct_path = xct_seg_path.split(str("/"))
        print(wbct_path)
        if "hrpqct" in xct_seg_path.lower():
            study = wbct_path[-4]
            wbct_path = str("/").join(wbct_path[:-3])
            wbct_path = str("/").join([wbct_path, study + "_WBCT"])
            wbct_bone_path = str("/").join([wbct_path, study + "_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"])
        else:
            study = wbct_path[-3]
            wbct_path = str("/").join(wbct_path[:-2])
            wbct_path = str("/").join([wbct_path, study + "_WBCT"])
            wbct_bone_path = str("/").join([wbct_path, study + "_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"])
        wbct_bone = sitk.ReadImage(wbct_bone_path, sitk.sitkUInt8)

        min_val = int(np.max(sitk.GetArrayFromImage(wbct_bone)))
        wbct_bone = bounding_box(wbct_bone, min_val, min_val)

        shape_stats = sitk.LabelShapeStatisticsImageFilter()
        shape_stats.SetComputeOrientedBoundingBox(True)
        shape_stats.Execute(wbct_bone)

        resampler = sitk.ResampleImageFilter()
        aligned_image_spacing = wbct_bone.GetSpacing()

        aligned_image_size = [int(math.ceil(shape_stats.GetOrientedBoundingBoxSize(1)[i] / aligned_image_spacing[i])) for i in range(3)]
        direction_mat = shape_stats.GetOrientedBoundingBoxDirection(1)
        aligned_image_direction = [
            direction_mat[1],
            direction_mat[4],
            direction_mat[7],
            direction_mat[0],
            direction_mat[3],
            direction_mat[6],
            direction_mat[2],
            direction_mat[5],
            direction_mat[8],
        ]
        resampler.SetInterpolator(sitk.sitkNearestNeighbor)
        resampler.SetOutputDirection(aligned_image_direction)
        resampler.SetOutputOrigin(shape_stats.GetOrientedBoundingBoxOrigin(1))
        resampler.SetOutputSpacing(aligned_image_spacing)
        resampler.SetSize(aligned_image_size)

        align_wbct_bone = resampler.Execute(wbct_bone)
        mc1_length = int(math.ceil((math.ceil(0.25*align_wbct_bone.GetSize()[2]*align_wbct_bone.GetSpacing()[2])/bb_masked_bone.GetSpacing()[2])))
        print(mc1_length)

        if "hrpqct" in xct_seg_path.lower(): 
            if slice_axis:
                bb_masked_bone = bb_masked_bone[:, :, size_z-mc1_length:]
                # bb_masked_bone = bb_masked_bone[:, :, :mc1_length]
            else:
                bb_masked_bone = bb_masked_bone[:, :, mc1_length:]
        else:
            if slice_axis:
                # bb_masked_bone = bb_masked_bone[:, :, size_z-mc1_length:]
                if "key" in xct_seg_path.lower():
                    # bb_masked_bone = bb_masked_bone[:, :, size_z-mc1_length:]
                    bb_masked_bone = bb_masked_bone[:, :, :mc1_length]
                else:
                    bb_masked_bone = bb_masked_bone[:, :, :mc1_length]
            else:
                # bb_masked_bone = bb_masked_bone[:, :, mc1_length:]
                bb_masked_bone = bb_masked_bone[0:mc1_length:, :, :]
            # bb_masked_bone = bb_masked_bone[size_z-mc1_length:, :, :]
            # bb_masked_bone = sitk.Resample(bb_masked_bone, obb_img, interpolator=sitk.sitkNearestNeighbor)
            # bb_masked_bone = bounding_box(masked_bone, min_val, min_val)
        sitk.WriteImage(bb_masked_bone, os.path.splitext(xct_seg_path)[0] + "_ROTATED_BB_CROP.nii")

    size_x = bb_masked_bone.GetSize()[0]
    size_y = bb_masked_bone.GetSize()[1]
    size_z = bb_masked_bone.GetSize()[2]

    # For some scans, we need to slice images in the Y direction
    if slice_axis:
        q1 = bb_masked_bone[0:int(size_x/2), 0:int(size_y/2), 0:size_z]
        q2 = bb_masked_bone[int(size_x/2):size_x, 0:int(size_y/2), 0:size_z]
        q3 = bb_masked_bone[0:int(size_x/2), int(size_y/2):size_y, 0:size_z]
        q4 = bb_masked_bone[int(size_x/2):size_x, int(size_y/2):size_y, 0:size_z]
        # q1 = bb_masked_bone[0:size_x, 0:int(size_y/2), 0:int(size_z/2)]
        # q2 = bb_masked_bone[0:size_x, 0:int(size_y/2), int(size_z/2):size_z]
        # q3 = bb_masked_bone[0:size_x, int(size_y/2):size_y, 0:int(size_z/2)]
        # q4 = bb_masked_bone[0:size_x, int(size_y/2):size_y, int(size_z/2):size_z]
    else:
        q1 = bb_masked_bone[0:int(size_x/2), 0:size_y, 0:int(size_z/2)]
        q2 = bb_masked_bone[int(size_x/2):size_x, 0:size_y, 0:int(size_z/2)]
        q3 = bb_masked_bone[0:int(size_x/2), 0:size_y, int(size_z/2):size_z]
        q4 = bb_masked_bone[int(size_x/2):size_x, 0:size_y, int(size_z/2):size_z]

    q1 = sitk.BinaryThreshold(q1, 1, 1, 1, 0)
    q2 = sitk.BinaryThreshold(q2, 1, 1, 2, 0)
    q3 = sitk.BinaryThreshold(q3, 1, 1, 3, 0)
    q4 = sitk.BinaryThreshold(q4, 1, 1, 4, 0)

    # For some scans, we need to slice images in the Y direction
    # Most of the time the Z direction works though
    i = sitk.Image(bb_masked_bone.GetSize(), sitk.sitkUInt8)
    i.SetDirection(bb_masked_bone.GetDirection())
    i.SetSpacing(bb_masked_bone.GetSpacing())
    i.SetOrigin(bb_masked_bone.GetOrigin())

    if slice_axis:
        i[0:int(size_x/2), 0:int(size_y/2), 0:size_z] = q1
        i[int(size_x/2):size_x, 0:int(size_y/2), 0:size_z] = q2
        i[0:int(size_x/2), int(size_y/2):size_y, 0:size_z] = q3
        i[int(size_x/2):size_x, int(size_y/2):size_y, 0:size_z] = q4
        # i[0:size_x, 0:int(size_y/2), 0:int(size_z/2)] = q1
        # i[0:size_x, 0:int(size_y/2), int(size_z/2):size_z] = q2
        # i[0:size_x, int(size_y/2):size_y, 0:int(size_z/2)] = q3
        # i[0:size_x, int(size_y/2):size_y, int(size_z/2):size_z] = q4
    else:
        i[0:int(size_x/2), 0:size_y, 0:int(size_z/2)] = q1
        i[int(size_x/2):size_x, 0:size_y, 0:int(size_z/2)] = q2
        i[0:int(size_x/2), 0:size_y, int(size_z/2):size_z] = q3
        i[int(size_x/2):size_x, 0:size_y, int(size_z/2):size_z] = q4

    i = sitk.Resample(i, xct_seg_img, interpolator=sitk.sitkNearestNeighbor)
    q1 = sitk.Resample(q1, xct_seg_img, interpolator=sitk.sitkNearestNeighbor)
    q2 = sitk.Resample(q2, xct_seg_img, interpolator=sitk.sitkNearestNeighbor)
    q3 = sitk.Resample(q3, xct_seg_img, interpolator=sitk.sitkNearestNeighbor)
    q4 = sitk.Resample(q4, xct_seg_img, interpolator=sitk.sitkNearestNeighbor)
    sitk.WriteImage(i, os.path.splitext(xct_seg_path)[0] + "_Q.nii")
    sitk.WriteImage(q1, os.path.splitext(xct_seg_path)[0] + "_Q1.nii")
    sitk.WriteImage(q2, os.path.splitext(xct_seg_path)[0] + "_Q2.nii")
    sitk.WriteImage(q3, os.path.splitext(xct_seg_path)[0] + "_Q3.nii")
    sitk.WriteImage(q4, os.path.splitext(xct_seg_path)[0] + "_Q4.nii")

    if "xct" in xct_seg_path.lower():
        gray_img_path = xct_seg_path[:-9] + ".nii"
        gray_img = sitk.ReadImage(gray_img_path, sitk.sitkFloat32)
        gray_q1 = sitk.Mask(gray_img, q1)
        gray_q2 = sitk.Mask(gray_img, q2)
        gray_q3 = sitk.Mask(gray_img, q3)
        gray_q4 = sitk.Mask(gray_img, q4)
        sitk.WriteImage(gray_q1, os.path.splitext(xct_seg_path)[0] + "_GRAY_Q1.nii")
        sitk.WriteImage(gray_q2, os.path.splitext(xct_seg_path)[0] + "_GRAY_Q2.nii")
        sitk.WriteImage(gray_q3, os.path.splitext(xct_seg_path)[0] + "_GRAY_Q3.nii")
        sitk.WriteImage(gray_q4, os.path.splitext(xct_seg_path)[0] + "_GRAY_Q4.nii")

    print('Total time taken: {} min'.format((timer()-main_start)/60))


if __name__ == "__main__":
    main()