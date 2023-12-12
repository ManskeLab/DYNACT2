"""
bounding_box.py

Created by:   Michael Kuczynski
Created on:   2023.01.10

Description: Crops a mask using the bounding box.
"""

import os
import argparse
import numpy as np
import SimpleITK as sitk


def bounding_box(mask, min_val, max_val):
    """
    Computes the bounding box of the input mask and crops the mask using the
    size and starting location of the bounding box.

    Parameters
    ----------
    mask : SimpleITK.Image

    Returns
    -------
    bounding_box_image : SimpleITK.Image
    """
    # Run connected components
    connected_comp = sitk.ConnectedComponentImageFilter()
    connected_comp_img = connected_comp.Execute(mask)

    # Relabel and sort by object size
    relabel = sitk.RelabelComponentImageFilter()
    relabel.SortByObjectSizeOn()
    relabel_img = relabel.Execute(connected_comp_img)

    thresh = sitk.BinaryThresholdImageFilter()
    thresh.SetLowerThreshold(min_val)
    thresh.SetUpperThreshold(max_val)
    thresh.SetOutsideValue(0)
    thresh.SetInsideValue(1)
    thresh_img = thresh.Execute(mask)

    stats_filter = sitk.LabelShapeStatisticsImageFilter()
    stats_filter.Execute(thresh_img)
  
    # Get the bounding box. Returns an array in the format:
    # [x_start, y_start, z_start, x_size, y_size, z_size]
    bounding_box_dim = np.array(stats_filter.GetBoundingBox(1))
    x_start = bounding_box_dim[0]
    y_start = bounding_box_dim[1]
    z_start = bounding_box_dim[2]
    x_end = x_start + bounding_box_dim[3]
    y_end = y_start + bounding_box_dim[4]
    z_end = z_start + bounding_box_dim[5]

    # Crop the image with the bounding box
    bounding_box_image = thresh_img[x_start:x_end, y_start:y_end, z_start:z_end]

    return bounding_box_image


def quadrant(mask_path, percentage=0.25):
    boundingbox_path = os.path.splitext(mask_path)[0]
    boundingbox_img_path = boundingbox_path + "_BOUNDINGBOX.nii"
    boundingbox_crop10_path = boundingbox_path + "_BOUNDINGBOX_CROP10.nii"
    boundingbox_crop25_path = boundingbox_path + "_BOUNDINGBOX_CROP25.nii"

    mask = sitk.ReadImage(mask_path, sitk.sitkUInt8)

    # Create 3 bounding box images
    # 1. Bounding box of the entire bone
    # 2. Bounding box of 25% of the bone from the joint surface (used for vBMD)
    # 3. Bounding box of 10% of the bone from the joint surface (used for quadrant definition)
    min_val = int(np.max(sitk.GetArrayFromImage(mask)))
    boundingbox_img = bounding_box(mask, min_val, min_val)
    sitk.WriteImage(boundingbox_img, boundingbox_img_path)

    if "MC1" in mask_path.upper():
        min_val = int(np.max(sitk.GetArrayFromImage(boundingbox_img)))
        boundingbox_img_crop_10 = bounding_box(boundingbox_img[0:boundingbox_img.GetSize()[0], 0:boundingbox_img.GetSize()[1], 0:int(boundingbox_img.GetSize()[2]*0.1)], min_val, min_val)
    elif "TRP" in mask_path.upper():
        min_val = int(np.max(sitk.GetArrayFromImage(boundingbox_img)))
        # boundingbox_img_crop_10 = bounding_box(boundingbox_img[0:boundingbox_img.GetSize()[0], 0:boundingbox_img.GetSize()[1], int(boundingbox_img.GetSize()[2]*0.75):boundingbox_img.GetSize()[2]], min_val, min_val)
        boundingbox_img_crop_10 = bounding_box(boundingbox_img[0:boundingbox_img.GetSize()[0], 0:boundingbox_img.GetSize()[1], 0:int(boundingbox_img.GetSize()[2]*0.35)], min_val, min_val)
    sitk.WriteImage(boundingbox_img_crop_10, boundingbox_crop10_path)

    min_val = int(np.max(sitk.GetArrayFromImage(boundingbox_img)))
    boundingbox_img_crop_25 = bounding_box(boundingbox_img[0:boundingbox_img.GetSize()[0], 0:boundingbox_img.GetSize()[1], 0:int(boundingbox_img.GetSize()[2]*percentage)], min_val, min_val)
    sitk.WriteImage(boundingbox_img_crop_25, boundingbox_crop25_path)

    # Separate into quadrants
    size_x = boundingbox_img_crop_10.GetSize()[0]
    size_x_25 = boundingbox_img_crop_25.GetSize()[0]
    size_y = boundingbox_img_crop_10.GetSize()[1]
    size_y_25 = boundingbox_img_crop_25.GetSize()[1]
    size_z = boundingbox_img_crop_25.GetSize()[2]

    q1 = boundingbox_img_crop_25[0:int(size_x/2), 0:int(size_y/2), 0:size_z]
    q2 = boundingbox_img_crop_25[int(size_x/2):size_x_25, 0:int(size_y/2), 0:size_z]
    q3 = boundingbox_img_crop_25[0:int(size_x/2), int(size_y/2):size_y_25, 0:size_z]
    q4 = boundingbox_img_crop_25[int(size_x/2):size_x_25, int(size_y/2):size_y_25, 0:size_z]

    q1 = sitk.BinaryThreshold(q1, 1, 1, 1, 0)
    q2 = sitk.BinaryThreshold(q2, 1, 1, 2, 0)
    q3 = sitk.BinaryThreshold(q3, 1, 1, 3, 0)
    q4 = sitk.BinaryThreshold(q4, 1, 1, 4, 0)

    i = sitk.Image(mask.GetSize(), sitk.sitkUInt8)
    i.SetDirection(mask.GetDirection())
    i.SetSpacing(mask.GetSpacing())
    # i.SetOrigin(boundingbox_img_crop_25.GetOrigin())
    i[0:int(size_x/2), 0:int(size_y/2), 0:size_z] = q1
    i[int(size_x/2):size_x_25, 0:int(size_y/2), 0:size_z] = q2
    i[0:int(size_x/2), int(size_y/2):size_y_25, 0:size_z] = q3
    i[int(size_x/2):size_x_25, int(size_y/2):size_y_25, 0:size_z] = q4

    # max_val = int(np.max(sitk.GetArrayFromImage(i)))
    # min_val = int(np.min(sitk.GetArrayFromImage(i)))
    # i = bounding_box(i, min_val, max_val)

    sitk.WriteImage(q1, os.path.splitext(mask_path)[0] + "_Q1.nii")
    sitk.WriteImage(q2, os.path.splitext(mask_path)[0] + "_Q2.nii")
    sitk.WriteImage(q3, os.path.splitext(mask_path)[0] + "_Q3.nii")
    sitk.WriteImage(q4, os.path.splitext(mask_path)[0] + "_Q4.nii")
    sitk.WriteImage(i, os.path.splitext(mask_path)[0] + "_Q.nii")

    
    return i

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Crop a mask using SimpleITK")
    parser.add_argument("mask_path", help="The mask image file path")
    parser.add_argument("percentage", type=float, default=0.25)
    args = parser.parse_args()

    mask_path = args.mask_path
    percentage = args.percentage

    # img = sitk.ReadImage(mask_path)
    # mesh_np = sitk.GetArrayFromImage(img)
    # mesh_np = np.max(mesh_np, axis=1)

    # mesh_sitk = sitk.GetImageFromArray(mesh_np)

    # sitk.WriteImage(mesh_sitk, os.path.splitext(mask_path)[0] + "_np.nii")

    # size_x = mesh_sitk.GetSize()[0]
    # size_y = mesh_sitk.GetSize()[1]
    # size_z = img.GetSize()[2]

    # q1 = img[0:int(size_x/2), 0:int(size_y/2), 0:size_z]
    # q2 = img[int(size_x/2):size_x, 0:int(size_y/2), 0:size_z]
    # q3 = img[0:int(size_x/2), int(size_y/2):size_y, 0:size_z]
    # q4 = img[int(size_x/2):size_x, int(size_y/2):size_y, 0:size_z]

    # q1 = sitk.BinaryThreshold(q1, 1, 1, 1, 0)
    # q2 = sitk.BinaryThreshold(q2, 1, 1, 2, 0)
    # q3 = sitk.BinaryThreshold(q3, 1, 1, 3, 0)
    # q4 = sitk.BinaryThreshold(q4, 1, 1, 4, 0)

    # i = sitk.Image(img.GetSize(), sitk.sitkUInt8)
    # i.SetDirection(img.GetDirection())
    # i.SetSpacing(img.GetSpacing())
    # i[0:int(size_x/2), 0:int(size_y/2), 0:size_z] = q1
    # i[int(size_x/2):size_x, 0:int(size_y/2), 0:size_z] = q2
    # i[0:int(size_x/2), int(size_y/2):size_y, 0:size_z] = q3
    # i[int(size_x/2):size_x, int(size_y/2):size_y, 0:size_z] = q4

    # sitk.WriteImage(q1, os.path.splitext(mask_path)[0] + "_Q1.nii")
    # sitk.WriteImage(q2, os.path.splitext(mask_path)[0] + "_Q2.nii")
    # sitk.WriteImage(q3, os.path.splitext(mask_path)[0] + "_Q3.nii")
    # sitk.WriteImage(q4, os.path.splitext(mask_path)[0] + "_Q4.nii")
    # sitk.WriteImage(i, os.path.splitext(mask_path)[0] + "_Q.nii")

    quad_img = quadrant(mask_path, percentage)