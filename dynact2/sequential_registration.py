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
    print("Entered into register_multiprocess:")
       
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
        
    print("\tRunning registration...", flush=True)
    final_tfm = registration(init_tfm, masked_next, masked_bone)

    final_image = sitk.Resample(masked_bone, grayscale_volume, transform=final_tfm)
    final_mask = sitk.Resample(bone_seg_ref, grayscale_volume, transform=final_tfm, interpolator=sitk.sitkNearestNeighbor)

    print("\tWriting registered image...", flush=True)
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
    """
    Parameters
    ----------
    dynact_dir : file path to volumes of resampled images (string)

    output_seg_directory : file path to RegisteredMasks (string)

    output_tmat_directory : file path to FinalTFMs (string)

    filelist : list of Volumes in Resampled directory (list[string])

    mc1_seg : file path to initial bone segmentation from WBCT (string)

    output_dir : file path to RegisteredMasks (string)

    frame_start : int

    frame_stop : int

    tolerance : percentage on Frame 1 intensity that must be achieved to complete registration (float)

    Returns
    -------
    none

    """

    # local variables
    counter = 0
    reset_counter = 0

    # reading in Frame 1 and WBCT segmentation 
    frame_1_dynact_path = os.path.join(dynact_dir, "Volume_" + str(1) + "_Resampled.nii")
    frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)
    frame_1_mc1_seg = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)

    # some preprocessing involving Frame 1 and WBCT segmentation
    mask = bounding_box(frame_1_mc1_seg, 1, 1)
    frame_1_dynact = sitk.Resample(frame_1_dynact, mask)
    mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
    frame_1_dynact = sitk.Mask(frame_1_dynact, mask)

    # calculating average intensity of Frame 1
    start_intensity_mc1 = ((sitk.GetArrayFromImage(frame_1_dynact)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(frame_1_dynact)) > 0)])).mean()

    # tolerance now converted into a value of absolute tolerance for image intensity 
    tolerance = tolerance * start_intensity_mc1

    # reading in SimpleITK.Image of starting frame
    start_frame_dynact_path = os.path.join(dynact_dir, "Volume_" + str(frame_start) + "_Resampled.nii")
    start_frame_dynact = sitk.ReadImage(start_frame_dynact_path, sitk.sitkFloat32)

    # if we START on the first frame, use the WBCT segmentation, else use the current mask 
    mc1_seg_start_dir = mc1_seg
    if frame_start == 1:
        mc1_seg_start = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
    else:
        mc1_seg_start_dir = os.path.join(output_seg_dir, "VOLUME_" + str(frame_start-1) + "_TO_" + str(frame_start) + "_MC1_MASK_REG.nii")
        mc1_seg_start = sitk.ReadImage(mc1_seg_start_dir, sitk.sitkUInt8)

    # 1. Mask bones from reference image
    mc1_seg_resampled = sitk.Resample(mc1_seg_start, start_frame_dynact, interpolator=sitk.sitkNearestNeighbor)

    prev_grayscale = start_frame_dynact
    prev_mc1_mask = mc1_seg_resampled

    # if we havent set a stop frame, we run through the number of images in the folder
    if frame_stop <= 0:
        frame_stop = len(filelist)-1
    
    # reindexes our frames so that start frame will show as previous frame, we will start registering the next frame
    frames = range(frame_start+1, frame_stop, 1)

    print(f"\n****************** METHOD SETUP COMPLETE **************************\n")
    print(f"\tFrame 1 Intensity = {start_intensity_mc1}")
    print(f"\tTarget Intensity = {tolerance}")
    print(f"\tStarting Volume = {frame_start}")
    print(f"\tFrames = {frames}")

    print(f"\n*******************************************************************")
    print(f"************************* FRAME {frames[0]} *********************************")
    print(f"*******************************************************************")

    index = 0
    while index < len(frames)-1:

        item = frames[index] # ie. frames[0] = 2 if no start frame is set

        print(f"\n****************** Attempt #{counter+1}, Counter Resets: {reset_counter} ******************\n", flush=True)
        print("Registering volume {} to volume {}".format(item-1, item), flush=True)

        # setting and printing the previous greyscale and mc1 masks based on frame and attempt number
        if (item % 18 > 0):

            # if we start from the beginning (frame 2) we will use the WBCT segmentation mask
            if item == 2:
                prev_mc1_mask_dir = mc1_seg_start_dir
                prev_mc1_mask = mc1_seg_resampled

            # otherwise, use the mask mask from the previous step
            else:
                prev_mc1_mask_dir = os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-2) + "_TO_" + str(item-1) + "_MC1_MASK_REG.nii")
                prev_mc1_mask = sitk.ReadImage(prev_mc1_mask_dir, sitk.sitkUInt8)

            # the previous grayscale will always be the volume from the previous step
            prev_greyscale_dir = os.path.join(dynact_dir, "Volume_" + str(item-1) + "_Resampled.nii")
            prev_grayscale = sitk.ReadImage(prev_greyscale_dir, sitk.sitkFloat32)
            print(f"prev_grayscale: {"/".join(prev_greyscale_dir.split("/")[8:])}", flush=True)
            print(f"prev_mc1_mask: {"/".join(prev_mc1_mask_dir.split("/")[8:])}", flush=True)

        # if it is on the 18th frame we set the previous grayscale to frame 1 and seg to the WBCTS
        else: 
            print("Reached end of full movement cycle.", flush=True)
            prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_1_Resampled.nii"), sitk.sitkFloat32)
            prev_mc1_mask = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
            print("prev_grayscale:", os.path.join(dynact_dir, "Volume_1_Resampled.nii"))
            print("prev_mc1_mask:", mc1_seg)

        # Get the next volume file
        current_file_path = os.path.join(dynact_dir, "Volume_" + str(item) + "_Resampled.nii")
        print("current_file_path:", "/".join(current_file_path.split("/")[8:]))
        print("Previous Frame: {}".format(item-1), flush=True)
        print("Current Frame: {}".format(item), flush=True)

        if not os.path.isfile(current_file_path):
            continue

        # Read in the next frame
        current_image = sitk.ReadImage(current_file_path, sitk.sitkFloat32)

        # NEED TO READ UP ON WHAT THIS PART DOES 

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

        # END - NEEDING TO READ UP ON ABOVE

        # Multiprocess the MC1 and TRP for each frame to speed things up
        print("Registering MC1 volume {} to volume {}".format(item-1, item), flush=True)

        if 0 < counter < 5:
            prev_tfm_dir = os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_REG.tfm")
            prev_tfm = sitk.ReadTransform(prev_tfm_dir)
            print("prev_tfm:", "/".join(prev_tfm_dir.split("/")[8:]))
            register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
                                tmat_hand_init, output_seg_dir, output_tmat_dir, prev_tfm)
        else:
            print("prev_tfm: None")
            register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
                              tmat_hand_init, output_seg_dir, output_tmat_dir)

        prev_grayscale = current_image

        if item == 2:
            prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_1_TO_2_MC1_MASK_REG.nii"), sitk.sitkUInt8)
        else:
            prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_MASK_REG.nii"), sitk.sitkUInt8)

        # Check the mean intensity and compare to "gold standard" (i.e., frame #1)
        mask = bounding_box(prev_mc1_mask, 1, 1)
        prev_grayscale = sitk.Resample(prev_grayscale, mask)
        mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
        prev_grayscale = sitk.Mask(prev_grayscale, mask)
        new_intensity_mc1 = ((sitk.GetArrayFromImage(prev_grayscale)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(prev_grayscale)) > 0)])).mean()

        print("REF MC1 INTENSITY:", start_intensity_mc1, flush=True)
        print("CURRENT MC1 INTENSITY:", new_intensity_mc1, flush=True)

        if isclose(start_intensity_mc1, new_intensity_mc1, abs_tol=tolerance):
            index += 1
            counter = 0
            reset_counter = 0
            print("Success! Moving to next frame...")

            print(f"\n*******************************************************************")
            print(f"************************* FRAME {item + 1} *********************************")
            print(f"*******************************************************************")

        else:
            print("Trying again...", flush=True)
            counter += 1

        # added to allow for more linear flow of counting from iteration to iteration
        if counter >= 5:
            counter = 0
            reset_counter += 1

        if reset_counter >= 5:
            print("Error: Cannot compute adequate alignment. 5 reset attempts failed. Exiting...", flush=True)
            sys.exit()

    # while loop end        


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

    # Compile a list of the files we need to register
    filelist = glob.glob(os.path.join(dynact_dir, '*Volume_*_Resampled.nii'))

    p1 = multiprocess.Process(target=mc1_reg, 
                                  args=(dynact_dir, output_seg_dir, 
                                        output_tmat_dir, filelist, 
                                        mc1_seg, output_dir, 
                                        frame_start, frame_stop, 0.15))
    
    p2 = multiprocess.Process(target=trp_reg, 
                                  args=(dynact_dir, output_seg_dir, 
                                        output_tmat_dir, filelist, 
                                        trp_seg, output_dir, 
                                        frame_start, frame_stop, 0.05))

    p1.start() 
    # p2.start() 

    p1.join() 
    # p2.join() 


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
