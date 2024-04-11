"""
sequential_registration.py

Created by:   Michael Kuczynski
Created on:   July 20, 2020

Description: Register dynamic CT image frames using sequential registration.
"""

import os
import sys
import glob
import errno
import argparse
import multiprocess 
import numpy as np
import SimpleITK as sitk

from math import isclose
from bounding_box_quad import bounding_box

np.seterr(divide='ignore', invalid='ignore')

def command_iteration(method):
    """
    Prints the registration method's metric and optimizer position during the
    image registration process.

    Parameters
    ----------
    method : SimpleITK.ImageRegistrationMethod

    Returns
    -------

    """
    print(
        "{0:3} = {1:10.5f} : {2}".format(
            method.GetOptimizerIteration(),
            method.GetMetricValue(),
            method.GetOptimizerPosition(),
        )
    )


def get_dynact_images(dynact_dir):
    """
    Loads all DYNACT images into an array.

    Parameters
    ----------
    dynact_dir : string

    Returns
    -------
    dynact_img_list : list
    """
    # Read in DYNACT images into an array
    # Array format:
    #       -dynact_img_list[i] = [volume_num, [MC1_SEG, TRP_SEG], grayscale_img]
    dynact_img_list = [None] * 60

    for i in range(1, 60, 1):
        # Get the next volume file
        next_file = os.path.join(dynact_dir, "Volume_" + str(i) + "_Resampled.nii")
        next_file_abs_path = os.path.join(dynact_dir, next_file)

        if not os.path.isfile(next_file_abs_path):
            continue

        # Get the volume number
        if next_file[-16] == "_":
            volume_num = int(next_file[-15:-14])
        else:
            volume_num = int(next_file[-16:-14])

        # Read the image
        next_volume = sitk.ReadImage(next_file_abs_path, sitk.sitkFloat32)
        # print("Reading: {}".format(next_file_abs_path))

        # Add the SimpleITK image to the volume list
        # Use the volume number to avoid sorting
        dynact_img_list[volume_num - 1] = [volume_num - 1, [None] * 2, next_volume]

    return dynact_img_list


def binary_resample(ref, img):
    """
    Resamples an input image (binary) using a reference image.

    Parameters
    ----------
    ref : SimpleITK.Image

    img : SimpleITK.Image

    Returns
    -------
    resampled : SimpleITK.Image
    """
    resample_filter = sitk.ResampleImageFilter()
    resample_filter.SetReferenceImage(ref)
    resample_filter.SetInterpolator(sitk.sitkNearestNeighbor)
    resample_filter.SetOutputPixelType(img.GetPixelID())
    resampled = resample_filter.Execute(img)

    return resampled


def binary_resample_tfm(ref, img, tmat):
    """
    Resamples an input image (binary) using a reference image and input TFM.

    Parameters
    ----------
    ref : SimpleITK.Image

    img : SimpleITK.Image

    tmat : SimpleITK.TFM

    Returns
    -------
    resampled : SimpleITK.Image
    """
    # FORMAT: sitk.Resample(imageToBeResampled, referenceImage, transformation,
    #                       interpolator, defaultPixelValue, outputPixelType)
    resampled = sitk.Resample(
        img, ref, tmat, sitk.sitkNearestNeighbor, 0.0, img.GetPixelID()
    )

    return resampled


def dilate_mask(seg_img, kernel=[15, 15, 1]):
    """
    Dilates a binary mask by a specified kernel size.

    Parameters
    ----------
    seg_img : SimpleITK.Image

    kernel : list

    Returns
    -------
    dilated_img : SimpleITK.Image
    """
    dilate = sitk.BinaryDilateImageFilter()
    dilate.SetKernelRadius(kernel)
    dilate.SetForegroundValue(1)
    dilated_img = dilate.Execute(seg_img)

    return dilated_img


def mask_bone(img, mask):
    """
    Masks an input image with a binary mask.

    Parameters
    ----------
    img : SimpleITK.Image

    mask : SimpleITK.Image

    Returns
    -------
    masked_img : SimpleITK.Image
    """
    return sitk.Mask(img, mask)


def initialize_tfm(fixed, moving):
    """
    Computes the initial transform between fixed and moving images by matching by
    the image geometric centres.

    Parameters
    ----------
    fixed : SimpleITK.Image

    moving : SimpleITK.Image

    Returns
    -------
    tmat : SimpleITK.TFM
    """
    # FORMAT: CenteredTransformInitializer (fixedImage, movingImage,
    #                                       transform, operationMode)
    tmat = sitk.CenteredTransformInitializer(
        fixed,
        moving,
        sitk.Similarity3DTransform(),
        sitk.CenteredTransformInitializerFilter.GEOMETRY,
    )

    return tmat


def registration(init_tmat, fixed, moving):
    """
    Performs image registration between a fixed and moving image.

    Parameters
    ----------
    init_tmat : SimpleITK.TFM

    fixed : SimpleITK.Image

    moving : SimpleITK.Image

    Returns
    -------
    final_tmat : SimpleITK.TFM
    """
    reg = sitk.ImageRegistrationMethod()

    # Similarity metric settings:
    # reg.SetMetricAsMattesMutualInformation(numberOfHistogramBins=50)
    reg.SetMetricAsMeanSquares()
    reg.SetMetricSamplingStrategy(reg.RANDOM)
    # reg.SetMetricSamplingPercentage(0.001)
    reg.SetMetricSamplingPercentagePerLevel([0.1, 0.01, 0.01], 0)
    reg.SetInterpolator(sitk.sitkLinear)
    reg.SetOptimizerAsRegularStepGradientDescent(learningRate=0.5,
        minStep=1e-8,
        numberOfIterations=500,
        gradientMagnitudeTolerance=1e-8)
    reg.SetOptimizerScalesFromPhysicalShift()
    reg.SetShrinkFactorsPerLevel(shrinkFactors=[4, 2, 1])
    reg.SetSmoothingSigmasPerLevel(smoothingSigmas=[2, 1, 0])
    reg.SmoothingSigmasAreSpecifiedInPhysicalUnitsOn()
    reg.SetInitialTransform(init_tmat, inPlace=False)

    # FORMAT: registration.Execute(fixedImage, movingImage)
    final_tmat = reg.Execute(fixed, moving)

    return final_tmat


def register_multiprocess(bone, volume_num, bone_seg_ref, grayscale_volume, 
                          masked_bone, hand_tfm, output_seg_dir, output_tfm_dir,
                          init_tfm=None):
    bone = str(bone).upper()
    # final_mask = queue.get()
       
    # Dilate the transformed bone mask to ensure we capture the bone
    seg_next_dilate = sitk.Resample(sitk.BinaryDilate(bone_seg_ref, (15,15,15)), 
                                    grayscale_volume, 
                                    transform=hand_tfm, 
                                    interpolator=sitk.sitkNearestNeighbor)
    
    mask = bounding_box(seg_next_dilate, 1, 1)
    mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], grayscale_volume)
    masked_next = sitk.Mask(grayscale_volume, mask)

    try:
        sitk.WriteImage(masked_next, os.path.join(output_seg_dir, "VOLUME_" + str(volume_num-1) + "_TO_" + str(volume_num) + "_" + str(bone) + "_MASKED_CROP.nii"))
    except:
        print("ERROR", flush=True)

    if init_tfm == None:
        init_tfm = initialize_tfm(masked_next, masked_bone)
    else:
        init_tfm = sitk.CompositeTransform(init_tfm)
        init_tfm = init_tfm.GetNthTransform(0)

    # sitk.WriteImage(sitk.Resample(masked_next, grayscale_volume, transform=init_tfm), os.path.join(output_seg_dir, "test.nii"))
    # sys.exit()
        
    # print("Running registration...", flush=True)
    final_tfm = registration(init_tfm, masked_next, masked_bone)

    final_image = sitk.Resample(masked_bone, grayscale_volume, transform=final_tfm)
    final_mask = sitk.Resample(bone_seg_ref, grayscale_volume, transform=final_tfm, interpolator=sitk.sitkNearestNeighbor)

    # print("Writing registered image...", flush=True)
    try:
        sitk.WriteImage(final_mask, os.path.join(output_seg_dir, "VOLUME_" + str(volume_num-1) + "_TO_" + str(volume_num) + "_" + str(bone) + "_MASK_REG.nii"))
    except:
        print("ERROR", flush=True)

    try:
        sitk.WriteImage(final_image, os.path.join(output_seg_dir, "VOLUME_" + str(volume_num-1) + "_TO_" + str(volume_num) + "_" + str(bone) + "_GRAY_REG.nii"))
    except:
        print("ERROR", flush=True)

    try:
        sitk.WriteTransform(final_tfm, os.path.join(output_tfm_dir, "VOLUME_" + str(volume_num-1) + "_TO_" + str(volume_num) + "_" + str(bone) + "_REG.tfm"))
    except:
        print("ERROR", flush=True)

    # sitk.WriteImage(masked_bone, os.path.join(output_seg_dir, "VOLUME_" + str(volume_num-1) + "_TO_" + str(volume_num-1) + "_" + str(bone) + "_MASKED.nii"))
    try:
        sitk.WriteImage(masked_next, os.path.join(output_seg_dir, "VOLUME_" + str(volume_num-1) + "_TO_" + str(volume_num) + "_" + str(bone) + "_MASKED.nii"))
    except:
        print("ERROR", flush=True)

    # return final_mask
    # queue.put(final_mask)
        

def mc1_reg(dynact_dir, output_seg_dir, output_tmat_dir, filelist, mc1_seg, output_dir, frame_start=1, frame_stop=0, tolerance=0.1):
    counter = 0
    reset_counter = 0

    frame_1_dynact_path = os.path.join(dynact_dir, "Volume_" + str(1) + "_Resampled.nii")
    frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)
    frame_1_mc1_seg = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)

    mask = bounding_box(frame_1_mc1_seg, 1, 1)
    frame_1_dynact = sitk.Resample(frame_1_dynact, mask)
    mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
    frame_1_dynact = sitk.Mask(frame_1_dynact, mask)

    start_intensity_mc1 = ((sitk.GetArrayFromImage(frame_1_dynact)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(frame_1_dynact)) > 0)])).mean()

    tolerance = tolerance * start_intensity_mc1

    start_frame_dynact_path = os.path.join(dynact_dir, "Volume_" + str(frame_start) + "_Resampled.nii")
    start_frame_dynact = sitk.ReadImage(start_frame_dynact_path, sitk.sitkFloat32)

    if frame_start == 1:
        mc1_seg_start = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
    else:
        mc1_seg_start = sitk.ReadImage(os.path.join(output_seg_dir, "VOLUME_" + str(frame_start-1) + "_TO_" + str(frame_start) + "_MC1_MASK_REG.nii"), sitk.sitkUInt8)

    # 1. Mask bones from reference image
    mc1_seg_resampled = sitk.Resample(mc1_seg_start, start_frame_dynact, interpolator=sitk.sitkNearestNeighbor)

    prev_grayscale = start_frame_dynact
    prev_mc1_mask = mc1_seg_resampled

    if frame_stop <= 0:
        frame_stop = len(filelist)-1
    
    frames = range(frame_start+1, frame_stop, 1)

    index = 0
    while index < len(frames)-1:
    # for index, item in enumerate(frames):
        item = frames[index]

        if not (item % 18):
            print("Reached end of full cycle.", flush=True)
            prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_1_Resampled.nii"), sitk.sitkFloat32)
            prev_mc1_mask = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
            print("prev_grayscale:", os.path.join(dynact_dir, "Volume_1_Resampled.nii"))
            print("prev_mc1_mask:", mc1_seg)
        # elif item == 16:
        #     print("15 to 16", flush=True)
        #     prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_17_Resampled.nii"), sitk.sitkFloat32)
        #     prev_mc1_mask = sitk.ReadImage(os.path.join(output_seg_dir, "VOLUME_16_TO_17_MC1_MASK_REG.nii"), sitk.sitkUInt8)
        #     print("prev_grayscale:", os.path.join(dynact_dir, "Volume_17_Resampled.nii"))
        #     print("prev_mc1_mask:", os.path.join(output_seg_dir, "VOLUME_16_TO_17_MC1_MASK_REG.nii"))
        else:
            if 0 < counter <= 5:
                if item == 2:
                    prev_grayscale = start_frame_dynact
                    prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_1_TO_2_MC1_MASK_REG2.nii"), sitk.sitkUInt8)
                    print("prev_grayscale:", start_frame_dynact_path)
                    print("prev_mc1_mask:", os.path.join(output_dir, "RegisteredMasks/VOLUME_1_TO_2_MC1_MASK_REG2.nii"))
                else:
                    prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_" + str(item-1) + "_Resampled.nii"), sitk.sitkFloat32)
                    prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-2) + "_TO_" + str(item-1) + "_MC1_MASK_REG.nii"), sitk.sitkUInt8)
                    print("prev_grayscale:", os.path.join(dynact_dir, "Volume_" + str(item-1) + "_Resampled.nii"))
                    print("prev_mc1_mask:", os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-2) + "_TO_" + str(item-1) + "_MC1_MASK_REG.nii"))
            if reset_counter >= 5:
                print("Error: Cannot compute adequate alignment. 5 attempts completed. Exiting...", flush=True)
                sys.exit()

        print("*****************************************************************", flush=True)
        print("Registering volume {} to volume {}".format(item-1, item), flush=True)

        # Get the next volume file
        current_file_path = os.path.join(dynact_dir, "Volume_" + str(item) + "_Resampled.nii")
        print("current_file_path:", current_file_path)

        print("Previous Frame: {}".format(item-1), flush=True)
        print("Current Frame: {}".format(item), flush=True)

        if not os.path.isfile(current_file_path):
            continue

        # Get the next frame
        current_image = sitk.ReadImage(current_file_path, sitk.sitkFloat32)

        current_hand_seg = sitk.BinaryThreshold(current_image, -200, 10000, 1, 0)
        prev_hand_seg = sitk.BinaryThreshold(prev_grayscale, -200, 10000, 1, 0)

        tmat_hand_init = sitk.CenteredTransformInitializer(
            current_hand_seg,
            prev_hand_seg,
            sitk.Similarity3DTransform(),
            sitk.CenteredTransformInitializerFilter.GEOMETRY,
        )

        prev_mc1_mask_dilate = sitk.Resample(sitk.BinaryDilate(prev_mc1_mask, (15,15,15)), 
                                 prev_grayscale, 
                                 interpolator=sitk.sitkNearestNeighbor)
        prev_masked_mc1 = mask_bone(prev_grayscale, prev_mc1_mask_dilate)

        # Multiprocess the MC1 and TRP for each frame to speed things up
        print("Registering MC1 volume {} to volume {}".format(item-1, item), flush=True)

        if 0 < counter <=5:
            prev_tfm = sitk.ReadTransform(os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_REG.tfm"))
            print("prev_tfm:", os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_REG.tfm"))
            register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
                                tmat_hand_init, output_seg_dir, output_tmat_dir, prev_tfm)
        else:
            print("prev_tfm: None")
            register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
                              tmat_hand_init, output_seg_dir, output_tmat_dir)
            reset_counter += 1
            counter = 0
        
        # a = sitk.Resample(prev_mc1_mask, current_image, transform=tmat_hand_init, interpolator=sitk.sitkNearestNeighbor)
        # sitk.WriteImage(a, os.path.join(output_dir, "FinalTFMs/aaaaa.nii"))
        # sys.exit()

        prev_grayscale = current_image

        if item == 2:
            prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_1_TO_2_MC1_MASK_REG2.nii"), sitk.sitkUInt8)
        # else:
        #     prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_MASK_REG.nii"), sitk.sitkUInt8)

        # Check the mean intensity and compare to "gold standard" (i.e., frame #1)
        mask = bounding_box(prev_mc1_mask, 1, 1)
        prev_grayscale = sitk.Resample(prev_grayscale, mask)
        mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
        prev_grayscale = sitk.Mask(prev_grayscale, mask)
        new_intensity_mc1 = ((sitk.GetArrayFromImage(prev_grayscale)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(prev_grayscale)) > 0)])).mean()

        # print(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_MASK_REG.nii"))
        # print(sitk.GetArrayFromImage(prev_grayscale)[sitk.GetArrayFromImage(prev_grayscale)>0])
        # sitk.WriteImage(mask, os.path.join(output_dir, "FinalTFMs/aaaaa.nii"))
        # sys.exit()

        print("REF MC1 INTENSITY:", start_intensity_mc1, flush=True)
        print("CURRENT MC1 INTENSITY:", new_intensity_mc1, flush=True)

        if isclose(start_intensity_mc1, new_intensity_mc1, abs_tol=tolerance):
            index += 1
            counter = 0
            reset_counter = 0
        else:
            # if item == 2:
            #     print("Can't get a good initial alignment at frame 1. Exiting...", flush=True)
            #     sys.exit()
            
            print("Trying again...", flush=True)
            counter += 1
            print("Attempt #{}".format(counter+1), flush=True)


def trp_reg(dynact_dir, output_seg_dir, output_tmat_dir, filelist, trp_seg, output_dir, frame_start=1, frame_stop=0, tolerance=0.1):
    counter = 0
    reset_counter = 0

    frame_1_dynact_path = os.path.join(dynact_dir, "Volume_" + str(1) + "_Resampled.nii")
    frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)
    frame_1_trp_seg = sitk.ReadImage(trp_seg, sitk.sitkUInt8)

    mask = bounding_box(frame_1_trp_seg, 1, 1)
    frame_1_dynact = sitk.Resample(frame_1_dynact, mask)
    mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
    frame_1_dynact = sitk.Mask(frame_1_dynact, mask)

    start_intensity_trp = ((sitk.GetArrayFromImage(frame_1_dynact)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(frame_1_dynact)) > 0)])).mean()

    tolerance = tolerance * start_intensity_trp

    start_frame_dynact_path = os.path.join(dynact_dir, "Volume_" + str(frame_start) + "_Resampled.nii")
    start_frame_dynact = sitk.ReadImage(start_frame_dynact_path, sitk.sitkFloat32)

    if frame_start == 1:
        trp_seg_start = sitk.ReadImage(trp_seg, sitk.sitkUInt8)
    else:
        trp_seg = os.path.join(output_seg_dir, "VOLUME_" + str(frame_start-1) + "_TO_" + str(frame_start) + "_TRP_MASK_REG.nii")
        trp_seg_start = sitk.ReadImage(trp_seg, sitk.sitkUInt8)

    # 1. Mask bones from reference image
    trp_seg_resampled = sitk.Resample(trp_seg_start, start_frame_dynact, interpolator=sitk.sitkNearestNeighbor)

    prev_grayscale = start_frame_dynact
    prev_trp_mask = trp_seg_resampled

    if frame_stop <= 0:
        frame_stop = len(filelist)-1
    
    frames = range(frame_start+1, frame_stop, 1)

    index = 0
    while index < len(frames)-1:
    # for index, item in enumerate(frames):
        item = frames[index]

        if not (item % 18):
            print("Reached end of full cycle.", flush=True)
            prev_grayscale = start_frame_dynact
            prev_trp_mask = trp_seg_resampled

        if 0 < counter <= 10:
            prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_" + str(item-1) + "_Resampled.nii"), sitk.sitkFloat32)
            prev_trp_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-2) + "_TO_" + str(item-1) + "_TRP_MASK_REG.nii"), sitk.sitkUInt8)
        if reset_counter >= 10:
            print("Error: Cannot compute adequate alignment. 10 attempts completed. Exiting...", flush=True)
            sys.exit()

        print("*****************************************************************", flush=True)
        print("Registering volume {} to volume {}".format(item-1, item), flush=True)

        # Get the next volume file
        current_file_path = os.path.join(dynact_dir, "Volume_" + str(item) + "_Resampled.nii")

        print("Previous Frame: {}".format(item-1), flush=True)
        print("Current Frame: {}".format(item), flush=True)

        if not os.path.isfile(current_file_path):
            continue

        # Get the next frame
        current_image = sitk.ReadImage(current_file_path, sitk.sitkFloat32)

        current_hand_seg = sitk.BinaryThreshold(current_image, -200, 10000, 1, 0)
        prev_hand_seg = sitk.BinaryThreshold(prev_grayscale, -200, 10000, 1, 0)

        tmat_hand_init = sitk.CenteredTransformInitializer(
            current_hand_seg,
            prev_hand_seg,
            sitk.Similarity3DTransform(),
            sitk.CenteredTransformInitializerFilter.GEOMETRY,
        )

        prev_trp_mask_dilate = sitk.Resample(sitk.BinaryDilate(prev_trp_mask, (15,15,15)), 
                                 prev_grayscale, 
                                 interpolator=sitk.sitkNearestNeighbor)
        prev_masked_trp = mask_bone(prev_grayscale, prev_trp_mask_dilate)

        # Multiprocess the trp and TRP for each frame to speed things up
        print("Registering trp volume {} to volume {}".format(item-1, item), flush=True)

        if 0 < counter <=10:
            prev_tfm = sitk.ReadTransform(os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_TRP_REG.tfm"))
            register_multiprocess("TRP", item, prev_trp_mask, current_image, prev_masked_trp, 
                                tmat_hand_init, output_seg_dir, output_tmat_dir, prev_tfm)
        else:
            register_multiprocess("TRP", item, prev_trp_mask, current_image, prev_masked_trp, 
                              tmat_hand_init, output_seg_dir, output_tmat_dir)
            reset_counter += 1
            counter = 0
        
        prev_grayscale = current_image

        if item == 2:
            prev_trp_mask = frame_1_trp_seg
        else:
            prev_trp_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_TRP_MASK_REG.nii"), sitk.sitkUInt8)

        # Check the mean intensity and compare to "gold standard" (i.e., frame #1)
        mask = bounding_box(prev_trp_mask, 1, 1)
        prev_grayscale = sitk.Resample(prev_grayscale, mask)
        mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
        prev_grayscale = sitk.Mask(prev_grayscale, mask)
        new_intensity_trp = ((sitk.GetArrayFromImage(prev_grayscale)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(prev_grayscale)) > 0)])).mean()

        print("REF TRP INTENSITY:", start_intensity_trp, flush=True)
        print("CURRENT TRP INTENSITY:", new_intensity_trp, flush=True)

        if isclose(start_intensity_trp, new_intensity_trp, abs_tol=tolerance):
            index += 1
            counter = 0
            reset_counter = 0
        else:
            if item == 2:
                print("Can't get a good initial alignment at frame 1. Exiting...", flush=True)
                sys.exit()
            
            print("Trying again...", flush=True)
            counter += 1
            print("Attempt #{}".format(counter+1), flush=True)


def main(dynact_dir, mc1_seg, trp_seg, output_dir, frame_start=1, frame_stop=0):
    """
    Main function to perform the sequential image registration.

    Parameters
    ----------
    dynact_dir : string

    mc1_seg : string

    trp_seg : string

    output_dir : string

    Returns
    -------

    """
    # Create the output directories
    output_tmat_dir = os.path.join(output_dir, "FinalTFMs")
    output_initial_transf_dir = os.path.join(output_dir, "InitalTransformations")
    output_seg_dir = output_dir + "/RegisteredMasks"

    try:
        os.mkdir(output_tmat_dir)
    except OSError as e:
        if e.errno != errno.EEXIST:  # Directory already exists error
            raise
    try:
        os.mkdir(output_initial_transf_dir)
    except OSError as e:
        if e.errno != errno.EEXIST:  # Directory already exists error
            raise
    try:
        os.mkdir(output_seg_dir)
    except OSError as e:
        if e.errno != errno.EEXIST:  # Directory already exists error
            raise

    # Count the number of files we need to register
    filelist = glob.glob(os.path.join(dynact_dir, '*Volume_*_Resampled.nii'))

    p1 = multiprocess.Process(target=mc1_reg, 
                                  args=(dynact_dir, output_seg_dir, 
                                        output_tmat_dir, filelist, 
                                        mc1_seg, output_dir, 
                                        frame_start, frame_stop, 0.12))
    
    p2 = multiprocess.Process(target=trp_reg, 
                                  args=(dynact_dir, output_seg_dir, 
                                        output_tmat_dir, filelist, 
                                        trp_seg, output_dir, 
                                        frame_start, frame_stop, 0.05))

    p1.start() 
    # p2.start() 

    p1.join() 
    # p2.join() 

    # mc1_reg(dynact_dir, output_seg_dir, output_tmat_dir, filelist, mc1_seg, output_dir, frame_start, frame_stop)
    # trp_reg(dynact_dir, output_seg_dir, output_tmat_dir, filelist, trp_seg, output_dir, frame_start, frame_stop)

    # # Load frame #1 image and seg file
    # # Then mask out the bone and compute the average intensity
    # # If the masked bone after registration differs in mean intensity (>10%), rerun the registration to attempt to get a better alignment
    # # To avoid infinite loops, do this 5 times. Then output an error message and quit.
    # counter = 0
    # reset_counter = 0

    # frame_1_dynact_path = os.path.join(dynact_dir, "Volume_" + str(1) + "_Resampled.nii")
    # frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)
    # frame_1_mc1_seg = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
    # # frame_1_trp_seg = sitk.ReadImage(trp_seg, sitk.sitkUInt8)
    
    # # bone = frame_1_dynact[:,:,0:int(frame_1_dynact.GetSize()[2]*0.75)]
    # mask = bounding_box(frame_1_mc1_seg, 1, 1)
    # frame_1_dynact = sitk.Resample(frame_1_dynact, mask)
    # mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
    # frame_1_dynact = sitk.Mask(frame_1_dynact, mask)
    # # sitk.WriteImage(frame_1_dynact, os.path.join(output_dir, "RegisteredMasks/test.nii"))
    
    # # mask = frame_1_mc1_seg[:,:,0:int(frame_1_mc1_seg.GetSize()[2]*0.75)]
    # # start_intensity_mc1 = ((sitk.GetArrayFromImage(bone)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(bone)) > 0)])).mean()
    # start_intensity_mc1 = ((sitk.GetArrayFromImage(frame_1_dynact)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(frame_1_dynact)) > 0)])).mean()

    # # start_intensity_trp = (sitk.GetArrayFromImage(frame_1_dynact)[sitk.GetArrayFromImage(frame_1_trp_seg) > 0]).mean()

    # tolerance = 0.12 * start_intensity_mc1

    # start_frame_dynact_path = os.path.join(dynact_dir, "Volume_" + str(frame_start) + "_Resampled.nii")
    # start_frame_dynact = sitk.ReadImage(start_frame_dynact_path, sitk.sitkFloat32)

    # if frame_start == 1:
    #     mc1_seg_start = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
    #     # trp_seg_ref = sitk.ReadImage(trp_seg, sitk.sitkUInt8)
    # else:
    #     mc1_seg = os.path.join(output_seg_dir, "VOLUME_" + str(frame_start-1) + "_TO_" + str(frame_start) + "_MC1_MASK_REG.nii")
    #     mc1_seg_start = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
    #     # trp_seg = os.path.join(output_seg_dir, "VOLUME_" + str(frame_start) + "_TO_" + str(frame_start+1) + "_TRP_MASK_REG.nii")
    #     # trp_seg_ref = sitk.ReadImage(trp_seg, sitk.sitkUInt8)



    # # 1. Mask bones from reference image
    # mc1_seg_resampled = sitk.Resample(mc1_seg_start, start_frame_dynact, interpolator=sitk.sitkNearestNeighbor)
    # # trp_seg_ref_resampled = sitk.Resample(trp_seg_ref, start_frame_dynact, interpolator=sitk.sitkNearestNeighbor)

    # # 2. Segment the hand from the reference image
    # # start_frame_dynact_hand_seg = sitk.BinaryThreshold(start_frame_dynact, 0, 10000, 1, 0)
    # # sitk.WriteImage(start_frame_dynact_hand_seg, os.path.join(output_dir, "VOLUME_REF_HAND_SEG.nii"))

    # # 3. Loop through all DYNACT frames and register the 1st volume to all others
    # # dynact_full_mask_list = [None] * len(filelist)
    # # dynact_full_mask_list[0] = [mc1_seg_ref, trp_seg_ref]

    # prev_grayscale = start_frame_dynact
    # prev_mc1_mask = mc1_seg_resampled
    # # prev_trp_mask = trp_seg_ref_resampled

    # if frame_stop <= 0:
    #     frame_stop = len(filelist)-1
    
    # frames = range(frame_start+1, frame_stop, 1)

    # index = 0
    # while index < len(frames)-1:
    # # for index, item in enumerate(frames):
    #     item = frames[index]

    #     # print("LOOP TOP:", flush=True)
    #     # print("index:", index, flush=True)
    #     # print("item:", item, flush=True)
    #     # print("counter:", counter, flush=True)
    #     # print(flush=True) 

    #     if not (item % 18):
    #         print("Reached end of full cycle.", flush=True)
    #         prev_grayscale = start_frame_dynact
    #         prev_mc1_mask = mc1_seg_resampled

    #     if 0 < counter <= 10:
    #         prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_" + str(item-1) + "_Resampled.nii"), sitk.sitkFloat32)
    #         prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-2) + "_TO_" + str(item-1) + "_MC1_MASK_REG.nii"), sitk.sitkUInt8)
    #     if reset_counter >= 10:
    #         print("Error: Cannot compute adequate alignment. 10 attempts completed. Exiting...", flush=True)
    #         sys.exit()

    #     # print("LOOP TOP2:", flush=True)
    #     # print("index:", index, flush=True)
    #     # print("item:", item, flush=True)
    #     # print("counter:", counter, flush=True)
    #     # print(flush=True)  

    #     print("*****************************************************************", flush=True)
    #     print("Registering volume {} to volume {}".format(item-1, item), flush=True)

    #     # Get the next volume file
    #     current_file_path = os.path.join(dynact_dir, "Volume_" + str(item) + "_Resampled.nii")

    #     print("Previous Frame: {}".format(item-1), flush=True)
    #     print("Current Frame: {}".format(item), flush=True)

    #     if not os.path.isfile(current_file_path):
    #         continue

    #     # Get the next frame
    #     current_image = sitk.ReadImage(current_file_path, sitk.sitkFloat32)

    #     current_hand_seg = sitk.BinaryThreshold(current_image, -200, 10000, 1, 0)
    #     prev_hand_seg = sitk.BinaryThreshold(prev_grayscale, -200, 10000, 1, 0)
    #     # sitk.WriteImage(current_hand_seg, os.path.join(output_dir, "VOLUME_" + str(item) + "_HAND_SEG.nii"))
    #     # sitk.WriteImage(prev_hand_seg, os.path.join(output_dir, "VOLUME_" + str(item-1) + "_HAND_SEG.nii"))

    #     tmat_hand_init = sitk.CenteredTransformInitializer(
    #         current_hand_seg,
    #         prev_hand_seg,
    #         sitk.Similarity3DTransform(),
    #         sitk.CenteredTransformInitializerFilter.GEOMETRY,
    #     )

    #     prev_mc1_mask_dilate = sitk.Resample(sitk.BinaryDilate(prev_mc1_mask, (15,15,15)), 
    #                              prev_grayscale, 
    #                              interpolator=sitk.sitkNearestNeighbor)
    #     prev_masked_mc1 = mask_bone(prev_grayscale, prev_mc1_mask_dilate)

    #     # Multiprocess the MC1 and TRP for each frame to speed things up
    #     print("Registering MC1 volume {} to volume {}".format(item-1, item), flush=True)
    #     # p1 = multiprocess.Process(target=register_multiprocess, 
    #     #                           args=("MC1", item, prev_mc1_mask, 
    #     #                                 current_image, prev_masked_mc1, 
    #     #                                 tmat_hand_init, 
    #     #                                 output_seg_dir, output_tmat_dir))

    #     # p1.start() 
    #     # p1.join() 
    #     if 0 < counter <=10:
    #         prev_tfm = sitk.ReadTransform(os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_REG.tfm"))
    #         # print(os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_REG.tfm"), flush=True)
    #         register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
    #                             tmat_hand_init, output_seg_dir, output_tmat_dir, prev_tfm)
    #     else:
    #         register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
    #                           tmat_hand_init, output_seg_dir, output_tmat_dir)
    #         reset_counter += 1
    #         counter = 0
        
    #     prev_grayscale = current_image
    #     prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_MASK_REG.nii"), sitk.sitkUInt8)

    #     # Check the mean intensity and compare to "gold standard" (i.e., frame #1)
    #     mask = bounding_box(prev_mc1_mask, 1, 1)
    #     prev_grayscale = sitk.Resample(prev_grayscale, mask)
    #     mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
    #     prev_grayscale = sitk.Mask(prev_grayscale, mask)
    #     new_intensity_mc1 = ((sitk.GetArrayFromImage(prev_grayscale)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(prev_grayscale)) > 0)])).mean()
    #     # bone = prev_grayscale[:,:,0:int(prev_grayscale.GetSize()[2]*0.75)]
    #     # mask = prev_mc1_mask[:,:,0:int(prev_mc1_mask.GetSize()[2]*0.75)]
    #     # new_intensity_mc1 = (sitk.GetArrayFromImage(bone)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(bone)) > 0)]).mean()

    #     print("REF MC1 INTENSITY:", start_intensity_mc1, flush=True)
    #     print("CURRENT MC1 INTENSITY:", new_intensity_mc1, flush=True)

    #     if isclose(start_intensity_mc1, new_intensity_mc1, abs_tol=tolerance):
    #         index += 1
    #         counter = 0
    #         reset_counter = 0
    #     else:
    #         if item == 2:
    #             print("Can't get a good initial alignment at frame 1. Exiting...", flush=True)
    #             sys.exit()
            
    #         print("Trying again...", flush=True)
    #         counter += 1
    #         print("Attempt #{}".format(counter+1), flush=True)
        
    #     # print("LOOP BOTTOM:", flush=True)
    #     # print("index:", index, flush=True)
    #     # print("item:", item, flush=True)
    #     # print("counter:", counter, flush=True)
    #     # print(flush=True)
    #     # print(flush=True)  







    # TRP
    # counter = 0
    # prev_grayscale = start_frame_dynact
    # prev_mc1_mask = mc1_seg_ref_resampled
    # prev_trp_mask = trp_seg_ref_resampled

    # for i in range(frame_start+1, frame_stop, 1):
    #     if counter > 0:
    #         i = i - 1
    #         prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_" + str(i) + "_Resampled.nii"), sitk.sitkFloat32)
    #         prev_trp_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(i-2) + "_TO_" + str(i-1) + "_TRP_MASK_REG.nii"), sitk.sitkUInt8)

    #     print("*****************************************************************", flush=True)
    #     print("Registering volume {} to volume {}".format(i-1, i), flush=True)

    #     # Get the next volume file
    #     current_file_path = os.path.join(dynact_dir, "Volume_" + str(i) + "_Resampled.nii")

    #     print("Previous Frame: {}".format(i-1), flush=True)
    #     print("Current Frame: {}".format(i), flush=True)

    #     if not os.path.isfile(current_file_path):
    #         continue

    #     # Get the next frame
    #     current_image = sitk.ReadImage(current_file_path, sitk.sitkFloat32)

    #     current_hand_seg = sitk.BinaryThreshold(current_image, -200, 10000, 1, 0)
    #     prev_hand_seg = sitk.BinaryThreshold(prev_grayscale, -200, 10000, 1, 0)
    #     sitk.WriteImage(current_hand_seg, os.path.join(output_dir, "VOLUME_" + str(i) + "_HAND_SEG.nii"))
    #     sitk.WriteImage(prev_hand_seg, os.path.join(output_dir, "VOLUME_" + str(i-1) + "_HAND_SEG.nii"))

    #     tmat_hand_init = sitk.CenteredTransformInitializer(
    #         current_hand_seg,
    #         prev_hand_seg,
    #         sitk.Similarity3DTransform(),
    #         sitk.CenteredTransformInitializerFilter.GEOMETRY,
    #     )

    #     prev_trp_mask_dilate = sitk.Resample(sitk.BinaryDilate(prev_trp_mask, (15,15,15)), 
    #                              prev_grayscale, 
    #                              interpolator=sitk.sitkNearestNeighbor)
    #     prev_masked_trp = mask_bone(prev_grayscale, prev_trp_mask_dilate)

    #     # Multiprocess the MC1 and TRP for each frame to speed things up
    #     print("Registering TRP volume {} to volume {}".format(i-1, i), flush=True)
    #     p2 = multiprocess.Process(target=register_multiprocess, 
    #                               args=("TRP", i, prev_trp_mask, 
    #                                     current_image, prev_masked_trp, 
    #                                     tmat_hand_init, output_seg_dir, output_tmat_dir))

    #     p2.start() 
    #     p2.join()
        
    #     prev_grayscale = current_image
    #     prev_trp_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(i-1) + "_TO_" + str(i) + "_TRP_MASK_REG.nii"), sitk.sitkUInt8)

    #     # Check the mean intensity and compare to "gold standard" (i.e., frame #1)
    #     # masked_trp_frame_i = mask_bone(prev_grayscale, prev_trp_mask)

    #     # stats_filter = sitk.StatisticsImageFilter()
    #     # stats_filter.Execute(masked_trp_frame_i)
    #     # new_intensity_trp = stats_filter.GetMean()
    #     new_intensity_trp = (sitk.GetArrayFromImage(prev_grayscale)[sitk.GetArrayFromImage(prev_trp_mask) > 0]).mean()

    #     print("REF TRP INTENSITY:", start_intensity_trp, flush=True)
    #     print("CURRENT TRP INTENSITY:", new_intensity_trp, flush=True)

    #     if np.isclose(new_intensity_trp, start_intensity_trp, atol=tolerance):
    #         counter = 0
    #         continue
    #     else:
    #         # Reset the previous volume and masks
    #         if counter > 5:
    #             print("Error: Cannot compute adequate alignment. 5 attempts completed. Exiting...", flush=True)
    #             sys.exit()

    #         prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_" + str(i) + "_Resampled.nii"), sitk.sitkFloat32)
    #         prev_trp_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(i-2) + "_TO_" + str(i-1) + "_TRP_MASK_REG.nii"), sitk.sitkUInt8)
    #         i = i - 1
    #         counter += 1
    #         print("Attempt #{}".format(counter+1), flush=True)
        
    #     print(flush=True)













        # if i >=25:
        #     sys.exit()

        
        # bb_mc1_seg_next = sitk.Resample(mc1_seg_ref_resampled, 
        #                                 next_image, 
        #                                 transform=tmat_hand_init, 
        #                                 interpolator=sitk.sitkNearestNeighbor)
        # bb_trp_seg_next = sitk.Resample(trp_seg_ref_resampled, 
        #                                 next_image, 
        #                                 transform=tmat_hand_init, 
        #                                 interpolator=sitk.sitkNearestNeighbor)

        # # Dilate the transformed bone mask to ensure we capture the bone
        # bb_mc1_seg_next_dilate = sitk.BinaryDilate(bb_mc1_seg_next, (9,9,9))
        # bb_trp_seg_next_dilate = sitk.BinaryDilate(bb_trp_seg_next, (9,9,9))
        # masked_next_mc1 = mask_bone(next_image, bb_mc1_seg_next_dilate)
        # masked_next_trp = mask_bone(next_image, bb_trp_seg_next_dilate)

        # init_tfm_mc1 = initialize_tfm(masked_next_mc1, masked_ref_mc1)
        # init_tfm_trp = initialize_tfm(masked_next_trp, masked_ref_trp)

        # final_mc1_tfm = registration(init_tfm_mc1, masked_next_mc1, masked_ref_mc1)
        # final_trp_tfm = registration(init_tfm_trp, masked_next_trp, masked_ref_trp)

        # final_image_mc1 = sitk.Resample(masked_ref_mc1, next_image, transform=final_mc1_tfm)
        # final_image_trp = sitk.Resample(masked_ref_trp, next_image, transform=final_trp_tfm)
        # final_mask_mc1 = sitk.Resample(mc1_seg_ref_resampled, next_image, transform=final_mc1_tfm)
        # final_mask_trp = sitk.Resample(trp_seg_ref_resampled, next_image, transform=final_trp_tfm)

        # sitk.WriteImage(final_mask_mc1, os.path.join(output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_MC1_FULLMASK_REG.nii"))
        # sitk.WriteImage(final_mask_trp, os.path.join(output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_TRP_FULLMASK_REG.nii"))
        # sitk.WriteImage(final_image_mc1, os.path.join(output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_MC1_REG.nii"))
        # sitk.WriteImage(final_image_trp, os.path.join(output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_TRP_REG.nii"))



    # # Resample the next MC1/TRP mask to match the DYNACT grayscale image
    # mc1_seg_img_resampled = binary_resample(frame_1_dynact, mc1_seg_img)
    # trp_seg_img_resampled = binary_resample(frame_1_dynact, trp_seg_img)

    # # Crop the MC1 and TRP from the first frame
    # # Dilate the MC1 and TRP segmentation masks
    # frame_1_dynact_mc1_seg = dilate_mask(mc1_seg_img_resampled)
    # frame_1_dynact_trp_seg = dilate_mask(trp_seg_img_resampled)

    # # Mask out each bone from the first frame
    # masked_mc1_img = mask_bone(frame_1_dynact, frame_1_dynact_mc1_seg)
    # masked_trp_img = mask_bone(frame_1_dynact, frame_1_dynact_trp_seg)

    # dynact_full_mask_list = [None] * len(filelist)
    # dynact_full_mask_list[0] = [mc1_seg_img, trp_seg_img]

    # # Loop through all DYNACT frames and register the first volume to all other volumes
    # # Registration is performed on the MC1 and TRP individually (to get frame 1 to all other frames TMAT)
    # # Then, using ITK, find the transformation between each frame and the next frame using the centroid of each mask (to get between frame TMATs)
    # ref_frame = frame_1_dynact
    # ref_frame_mc1_mask = mc1_seg_img_resampled  # Only used for cropping
    # ref_frame_trp_mask = trp_seg_img_resampled  # Only used for cropping
    # ref_frame_mc1_masked = masked_mc1_img  # Masked reference MC1
    # ref_frame_trp_masked = masked_trp_img  # Masked reference TRP
    # ref_frame_mc1_full_mask = dynact_full_mask_list[0][0]  # What we actually transform
    # ref_frame_trp_full_mask = dynact_full_mask_list[0][1]  # What we actually transform

    # prev_frame_mc1_mask = mc1_seg_img_resampled
    # prev_frame_trp_mask = trp_seg_img_resampled

    # for i in range(1, len(filelist)-1, 1):
    #     print("Registering volume {} to volume {}".format(i, i + 1))

    #     # Get the next volume file
    #     current_file_path = os.path.join(dynact_dir, "Volume_" + str(i) + "_Resampled.nii")
    #     next_file_path = os.path.join(dynact_dir, "Volume_" + str(i+1) + "_Resampled.nii")

    #     print("Reading in {}".format(current_file_path))
    #     print("Reading in {}".format(next_file_path))

    #     if not os.path.isfile(next_file_path):
    #         continue

    #     # Get the next frame
    #     previous_frame = sitk.ReadImage(current_file_path, sitk.sitkFloat32)
    #     current_frame = sitk.ReadImage(next_file_path, sitk.sitkFloat32)

    #     # Set the output file names
    #     # Keep number to match the input volume numbering (i.e., 1...60, not 0...59)
    #     mc1_inital_transf_path = os.path.join(
    #         output_initial_transf_dir,
    #         "VOLUME_REF_TO_" + str(i + 1) + "_MC1_INITAL_TRANSF.nii",
    #     )
    #     trp_inital_transf_path = os.path.join(
    #         output_initial_transf_dir,
    #         "VOLUME_REF_TO_" + str(i + 1) + "_TRP_INITAL_TRANSF.nii",
    #     )
    #     mc1_final_tfm_output_path = os.path.join(
    #         output_tmat_dir, "VOLUME_REF_TO_" + str(i + 1) + "_MC1_REG.tfm"
    #     )
    #     trp_final_tfm_output_path = os.path.join(
    #         output_tmat_dir, "VOLUME_REF_TO_" + str(i + 1) + "_TRP_REG.tfm"
    #     )
    #     mc1_final_image_output_path = os.path.join(
    #         output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_MC1_REG.nii"
    #     )
    #     trp_final_image_output_path = os.path.join(
    #         output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_TRP_REG.nii"
    #     )
    #     mc1_final_mask_output_path = os.path.join(
    #         output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_MC1_MASK_REG.nii"
    #     )
    #     trp_final_mask_output_path = os.path.join(
    #         output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_TRP_MASK_REG.nii"
    #     )
    #     mc1_final_full_mask_output_path = os.path.join(
    #         output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_MC1_FULLMASK_REG.nii"
    #     )
    #     trp_final_full_mask_output_path = os.path.join(
    #         output_seg_dir, "VOLUME_REF_TO_" + str(i + 1) + "_TRP_FULLMASK_REG.nii"
    #     )

    #     if os.path.isfile(mc1_final_image_output_path) or os.path.isfile(trp_final_image_output_path):
    #         continue

    #     # Initialize the registration by using the previous frame
    #     inital_transform_prev_to_current = initialize_tfm(current_frame, previous_frame)

    #     # Crop out the next_frame MC1 and TRP bones so the registration method has less area to iterate over
    #     # Mask the current frame MC1 and TRP
    #     mc1_seg_inital_transform_prev_to_curr = binary_resample_tfm(
    #         current_frame, prev_frame_mc1_mask, inital_transform_prev_to_current
    #     )
    #     trp_seg_inital_transform_prev_to_curr = binary_resample_tfm(
    #         current_frame, prev_frame_trp_mask, inital_transform_prev_to_current
    #     )

    #     mc1_current_frame_dilate_img = dilate_mask(
    #         mc1_seg_inital_transform_prev_to_curr
    #     )
    #     trp_current_frame_dilate_img = dilate_mask(
    #         trp_seg_inital_transform_prev_to_curr
    #     )

    #     mc1_current_frame_gray_masked = mask_bone(
    #         current_frame, mc1_current_frame_dilate_img
    #     )
    #     trp_current_frame_gray_masked = mask_bone(
    #         current_frame, trp_current_frame_dilate_img
    #     )

    #     inital_transform_ref_to_current_mc1 = initialize_tfm(
    #         mc1_current_frame_gray_masked, ref_frame_mc1_masked
    #     )
    #     inital_transform_ref_to_current_trp = initialize_tfm(
    #         trp_current_frame_gray_masked, ref_frame_trp_masked
    #     )

    #     # Start the registration
    #     # MC1
    #     final_tfm_mc1 = registration(
    #         inital_transform_ref_to_current_mc1,
    #         mc1_current_frame_gray_masked,
    #         ref_frame_mc1_masked,
    #     )
    #     final_tfm_trp = registration(
    #         inital_transform_ref_to_current_trp,
    #         trp_current_frame_gray_masked,
    #         ref_frame_trp_masked,
    #     )

    #     print("Writing to {}".format(mc1_final_tfm_output_path))
    #     sitk.WriteTransform(final_tfm_mc1, mc1_final_tfm_output_path)

    #     print("Writing to {}".format(trp_final_tfm_output_path))
    #     sitk.WriteTransform(final_tfm_trp, trp_final_tfm_output_path)

    #     # Resample images
    #     print("Resampling MC1")
    #     mc1_current_gray_resampled = binary_resample_tfm(
    #         current_frame, ref_frame_mc1_masked, final_tfm_mc1
    #     )
    #     mc1_current_seg_full_resampled = sitk.Resample(
    #         ref_frame_mc1_full_mask,
    #         current_frame.GetSize(),
    #         final_tfm_mc1,
    #         sitk.sitkNearestNeighbor,
    #         ref_frame_mc1_full_mask.GetOrigin(),
    #         ref_frame_mc1_full_mask.GetSpacing(),
    #         ref_frame_mc1_full_mask.GetDirection(),
    #         0,
    #         ref_frame_mc1_full_mask.GetPixelID(),
    #     )

    #     print("Writing to {}".format(mc1_final_image_output_path))
    #     sitk.WriteImage(mc1_current_gray_resampled, mc1_final_image_output_path)
    #     sitk.WriteImage(mc1_current_seg_full_resampled, mc1_final_full_mask_output_path)

    #     print("Resampling TRP")
    #     trp_current_gray_resampled = binary_resample_tfm(
    #         current_frame, ref_frame_trp_masked, final_tfm_trp
    #     )
    #     trp_current_seg_full_resampled = sitk.Resample(
    #         ref_frame_trp_full_mask,
    #         current_frame.GetSize(),
    #         final_tfm_trp,
    #         sitk.sitkNearestNeighbor,
    #         ref_frame_trp_full_mask.GetOrigin(),
    #         ref_frame_trp_full_mask.GetSpacing(),
    #         ref_frame_trp_full_mask.GetDirection(),
    #         0,
    #         ref_frame_trp_full_mask.GetPixelID(),
    #     )

    #     print("Writing to {}".format(trp_final_image_output_path))
    #     sitk.WriteImage(trp_current_gray_resampled, trp_final_image_output_path)
    #     sitk.WriteImage(trp_current_seg_full_resampled, trp_final_full_mask_output_path)

    #     prev_frame_mc1_mask = mc1_current_seg_full_resampled
    #     prev_frame_trp_mask = trp_current_seg_full_resampled


if __name__ == "__main__":
    # Parse input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("dynact_dir", type=str)
    parser.add_argument("mc1_seg", type=str)
    parser.add_argument("trp_seg", type=str)
    parser.add_argument("output_dir", type=str)
    parser.add_argument("-s", dest="frame_start", type=int, default=1)
    parser.add_argument("-e", dest="frame_end", type=int, default=0)
    args = parser.parse_args()

    dynact_dir = args.dynact_dir
    mc1_seg = args.mc1_seg
    trp_seg = args.trp_seg
    output_dir = args.output_dir
    frame_start = args.frame_start
    frame_end = args.frame_end

    main(dynact_dir, mc1_seg, trp_seg, output_dir, frame_start, frame_end)
