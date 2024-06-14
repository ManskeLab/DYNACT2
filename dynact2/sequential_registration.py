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

import matplotlib.pyplot as plt

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


def registration(init_tmat, fixed, moving, metric, optimizer, interpolator):
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
    match metric:
        case 'MeanSquares':
            reg.SetMetricAsMeanSquares()
            reg.SetMetricSamplingStrategy(reg.RANDOM)
            reg.SetMetricSamplingPercentagePerLevel([0.1, 0.01, 0.01], 0)
            print(f"\t\tMetric: MeanSquares")
        case 'MMI':
            reg.SetMetricAsMattesMutualInformation(numberOfHistogramBins=50)
            reg.SetMetricSamplingStrategy(reg.RANDOM)
            reg.SetMetricSamplingPercentage(0.001)
            print(f"\t\tMetric: MMI")

    # optimizer settings
    match optimizer:
        case 'GradientDescent':
            reg.SetOptimizerAsRegularStepGradientDescent(
                learningRate=0.5,
                minStep=1e-8,
                numberOfIterations=500,
                gradientMagnitudeTolerance=1e-8
            )
            print(f"\t\tOptimizer: GradientDescent")
        case 'Powell':
            reg.SetOptimizerAsPowell()
            print(f"\t\tOptimizer: Powell")
        # case 'Exhaustive':
        #     reg.SetOptimizerAsExhaustive(
        #         numberOfSteps=[10,10,10], 
        #         stepLength=1
        #     )
        #     print(f"\t\tOptimizer: Exhaustive")
        case 'Amoeba':
            reg.SetOptimizerAsAmoeba(
                numberOfIterations=500,
                simplexDelta=1
            )
            print(f"\t\tOptimizer: Amoeba")
        case 'OnePlusOne':
            reg.SetOptimizerAsOnePlusOneEvolutionary()
            print(f"\t\tOptimizer: OnePlusOne")
    
    # interpolator settings:
    match interpolator:
        case 'Linear':
            reg.SetInterpolator(sitk.sitkLinear)
            print(f"\t\tInterpolator: Linear")
        case 'NearestNeighbor':
            reg.SetInterpolator(sitk.sitkNearestNeighbor)
            print(f"\t\tInterpolator: NearestNeighbor")
        case 'BSpline': # slow
            reg.SetInterpolator(sitk.sitkBSpline)
            print(f"\t\tInterpolator: BSpline")
        # case 'Gaussian': # slooooow
        #     reg.SetInterpolator(sitk.sitkGaussian)
        #     print(f"\t\tInterpolator: Gaussian")
        # case 'Hamming': # really slow!
        #     reg.SetInterpolator(sitk.sitkHammingWindowedSinc)
        #     print(f"\t\tInterpolator: Hamming")
    
    # setting to allow a change in rotation to have similar effect to change in translation
    reg.SetOptimizerScalesFromPhysicalShift()

    # multi-resolution framework
    reg.SetShrinkFactorsPerLevel(shrinkFactors=[4, 2, 1])
    reg.SetSmoothingSigmasPerLevel(smoothingSigmas=[2, 1, 0])
    reg.SmoothingSigmasAreSpecifiedInPhysicalUnitsOn()
    reg.SetInitialTransform(init_tmat, inPlace=False)

    # FORMAT: registration.Execute(fixedImage, movingImage)
    final_tmat = reg.Execute(fixed, moving)

    return final_tmat


def register_multiprocess(bone, volume_num, bone_seg_ref, grayscale_volume, 
                          masked_bone, hand_tfm, output_seg_dir, output_tfm_dir,
                          init_tfm=None, metric='MeanSquares', optimizer='GradientDescent', interpolator='Linear'):
    """
    Prepares images and initial transformations for registration and saves registration outputs

    Parameters
    ----------
    bone : string

    volume_num : int

    bone_seg_ref :  (SimpleITK.Image) ex. prev_mc1_mask

    grayscale_volume :  (SimpleITK.Image) ex. current_image

    masked_bone : (SimpleITK.Image) ex. prev_masked_mc1

    hand_tfm : centre alignment of previous and current images (SimpleITK.Image) ex. tmat_hand_init

    output_seg_dir : file path to RegisteredMasks (string)

    output_tfm_dir : file path to FinalTFMs (string)

    init_tfm: transformation from previous iteration if required (SimpleITK.Image) ex. prev_tfm

    Returns
    -------
    none

    """
    bone = str(bone).upper()
    # final_mask = queue.get()
    print("Entered into register_multiprocess:")
       
    # Dilate the transformed bone mask to ensure we capture the bone
    seg_next_dilate = sitk.Resample(sitk.BinaryDilate(bone_seg_ref, (15,15,15)), 
                                    grayscale_volume, 
                                    transform=hand_tfm, 
                                    interpolator=sitk.sitkNearestNeighbor)
    
    # essentially i think this crops the grayscale so that we are only looking at the bone in question
    mask = bounding_box(seg_next_dilate, 1, 1)
    mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], grayscale_volume)
    masked_next = sitk.Mask(grayscale_volume, mask)

    try:
        sitk.WriteImage(masked_next, os.path.join(output_seg_dir, "VOLUME_" + str(volume_num-1) + "_TO_" + str(volume_num) + "_" + str(bone) + "_MASKED_CROP.nii"))
    except:
        print("ERROR", flush=True)

    # use a centred alignment transformation if we have no initial transformation otherwise use the previous iterations TFM
    if init_tfm == None:
        init_tfm = initialize_tfm(masked_next, masked_bone)
    else:
        init_tfm = sitk.CompositeTransform(init_tfm)
        init_tfm = init_tfm.GetNthTransform(0)

    # sitk.WriteImage(sitk.Resample(masked_next, grayscale_volume, transform=init_tfm), os.path.join(output_seg_dir, "test.nii"))
    # sys.exit()
        
    print("\tRunning registration...", flush=True)
    final_tfm = registration(init_tfm, masked_next, masked_bone, metric, optimizer, interpolator)

    # aligns the images with the grayscale by using the transform from the registration
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

    ##### STEP 1: METHOD SETUP #####

    # local variables
    optimizers = {
        0: 'GradientDescent',
        1: 'Powell',
        2: 'Amoeba',
        3: 'OnePlusOne'
    }

    interpolators = {
        0: 'Linear',
        1: 'NearestNeighbor',
        2: 'BSpline'
    }

    counter = 0
    max_counter = 5
    reset_counter = 0
    max_reset = len(optimizers) * len(interpolators)
    optimizer_index = 0
    interpolator_index = 0

    # reading in Frame 1 and WBCT segmentation 
    frame_1_dynact_path = os.path.join(dynact_dir, "Volume_" + str(1) + "_Resampled.nii")
    frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)
    frame_1_mc1_seg = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)

    # Crop Frame 1 using the WBCT segmentation, calculate "Gold Standard" intensity, set absolute tolerance 
    mask = bounding_box(frame_1_mc1_seg, 1, 1)
    frame_1_dynact = sitk.Resample(frame_1_dynact, mask)
    mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
    frame_1_dynact = sitk.Mask(frame_1_dynact, mask)
    start_intensity_mc1 = ((sitk.GetArrayFromImage(frame_1_dynact)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(frame_1_dynact)) > 0)])).mean()
    tolerance = tolerance * start_intensity_mc1

    # reading in SimpleITK.Image of starting frame
    start_frame_dynact_path = os.path.join(dynact_dir, "Volume_" + str(frame_start) + "_Resampled.nii")
    start_frame_dynact = sitk.ReadImage(start_frame_dynact_path, sitk.sitkFloat32)

    # if we start on the first frame, use the WBCT segmentation, else use the most recent registered mask
    mc1_seg_start_dir = mc1_seg
    if frame_start > 1:
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


        ##### STEP 2: READING IN FILES FOR USE IN REGISTRATION #####
        # based on frame and iteration


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


        ##### STEP 3: IMAGE PREPROCESSING AND REGISTRATION #####


        # basically convert image to black and white based on a set intensity threshold
        current_hand_seg = sitk.BinaryThreshold(current_image, -200, 10000, 1, 0)
        prev_hand_seg = sitk.BinaryThreshold(prev_grayscale, -200, 10000, 1, 0)

        # aligns centers of both images
        tmat_hand_init = sitk.CenteredTransformInitializer(
            current_hand_seg,
            prev_hand_seg,
            sitk.Similarity3DTransform(),
            sitk.CenteredTransformInitializerFilter.GEOMETRY,
        )

        # dialate previous mask (seems to reduce edges) and resample to previous grayscale
        # what is this actually doing... i don't know
        prev_mc1_mask_dilate = sitk.Resample(sitk.BinaryDilate(prev_mc1_mask, (15,15,15)), 
                                 prev_grayscale, 
                                 interpolator=sitk.sitkNearestNeighbor)
        prev_masked_mc1 = mask_bone(prev_grayscale, prev_mc1_mask_dilate)

        # Multiprocess the MC1 and TRP for each frame to speed things up
        print("Registering MC1 volume {} to volume {}".format(item-1, item), flush=True)

        metric = 'MeanSquares'
        optimizer = optimizers.get(optimizer_index)
        interpolator = interpolators.get(interpolator_index)

        # if its the first iteration in a set of attempts, run registration with no pref_tfm
        if counter == 0:
            print("prev_tfm: None")
            register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
                              tmat_hand_init, output_seg_dir, output_tmat_dir, metric=metric, optimizer=optimizer, interpolator=interpolator)
        
        # otherwise, use the transformation from the previous attempt as a parameter in this registration
        else:
            prev_tfm_dir = os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_REG.tfm")
            prev_tfm = sitk.ReadTransform(prev_tfm_dir)
            print("prev_tfm:", "/".join(prev_tfm_dir.split("/")[8:]))
            register_multiprocess("MC1", item, prev_mc1_mask, current_image, prev_masked_mc1, 
                                tmat_hand_init, output_seg_dir, output_tmat_dir, prev_tfm, metric, optimizer, interpolator)


        prev_grayscale = current_image
        prev_mc1_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_MC1_MASK_REG.nii"), sitk.sitkUInt8)


        # Check the mean intensity and compare to "gold standard" (i.e., frame #1)
        # Once again, I think what this crops the grayscale (which is the current image now...) to only show the bone in question
        # that way we can accurately compare average intensity
        mask = bounding_box(prev_mc1_mask, 1, 1)
        prev_grayscale = sitk.Resample(prev_grayscale, mask)
        mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
        prev_grayscale = sitk.Mask(prev_grayscale, mask)
        new_intensity_mc1 = ((sitk.GetArrayFromImage(prev_grayscale)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(prev_grayscale)) > 0)])).mean()

        print("REF MC1 INTENSITY:", start_intensity_mc1, flush=True)
        print("CURRENT MC1 INTENSITY:", new_intensity_mc1, flush=True)


        ##### STEP 4: END OF LOOP CONTROL LOGIC #####


        # if we are inside the threshold, move to the next frame
        # otherwise, we try again and iterate the counter
        if isclose(start_intensity_mc1, new_intensity_mc1, abs_tol=tolerance):
            index += 1
            counter = 0
            reset_counter = 0
            interpolator_index = 0
            optimizer_index = 0
            print("Success! Moving to next frame...")

            print(f"\n*******************************************************************")
            print(f"************************* FRAME {item + 1} *********************************")
            print(f"*******************************************************************")

        else:
            print("Trying again...", flush=True)
            counter += 1

        # if the counter iterates past our arbitrary max, we rest it to 0 and iterate the reset counter
        if counter >= max_counter:
            counter = 0
            reset_counter += 1

            if interpolator_index < len(interpolators) - 1:
                interpolator_index +=1
            else:
                interpolator_index = 0

                if optimizer_index < len(optimizers) - 1:
                    optimizer_index +=1
                else:
                    optimizer_index = 0

        # if we go through 5 sets of resets, we give up
        if reset_counter >= max_reset:
            print(f"Error: Cannot compute adequate alignment. {max_reset} reset attempts failed. Exiting...", flush=True)
            sys.exit()

    # while loop end        


def trp_reg(dynact_dir, output_seg_dir, output_tmat_dir, filelist, trp_seg, output_dir, frame_start=1, frame_stop=0, tolerance=0.1):
    """
    Parameters
    ----------
    dynact_dir : file path to volumes of resampled images (string)

    output_seg_directory : file path to RegisteredMasks (string)

    output_tmat_directory : file path to FinalTFMs (string)

    filelist : list of Volumes in Resampled directory (list[string])

    trp_seg : file path to initial bone segmentation from WBCT (string)

    output_dir : file path to RegisteredMasks (string)

    frame_start : int

    frame_stop : int

    tolerance : percentage on Frame 1 intensity that must be achieved to complete registration (float)

    Returns
    -------
    none

    """

    ##### STEP 1: METHOD SETUP #####

    # local variables
    optimizers = {
        0: 'GradientDescent',
        1: 'Powell',
        2: 'Amoeba',
        3: 'OnePlusOne'
    }

    interpolators = {
        0: 'Linear',
        1: 'NearestNeighbor',
        2: 'BSpline'
    }

    counter = 0
    max_counter = 5
    reset_counter = 0
    max_reset = len(optimizers) * len(interpolators)
    optimizer_index = 0
    interpolator_index = 0

    # reading in Frame 1 and WBCT segmentation 
    frame_1_dynact_path = os.path.join(dynact_dir, "Volume_" + str(1) + "_Resampled.nii")
    frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)
    frame_1_trp_seg = sitk.ReadImage(trp_seg, sitk.sitkUInt8)

    # Crop Frame 1 using the WBCT segmentation, calculate "Gold Standard" intensity, set absolute tolerance 
    mask = bounding_box(frame_1_trp_seg, 1, 1)
    frame_1_dynact = sitk.Resample(frame_1_dynact, mask)
    mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
    frame_1_dynact = sitk.Mask(frame_1_dynact, mask)
    start_intensity_trp = ((sitk.GetArrayFromImage(frame_1_dynact)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(frame_1_dynact)) > 0)])).mean()
    tolerance = tolerance * start_intensity_trp

    # reading in SimpleITK.Image of starting frame
    start_frame_dynact_path = os.path.join(dynact_dir, "Volume_" + str(frame_start) + "_Resampled.nii")
    start_frame_dynact = sitk.ReadImage(start_frame_dynact_path, sitk.sitkFloat32)

    # if we start on the first frame, use the WBCT segmentation, else use the most recent registered mask
    trp_seg_start_dir = trp_seg
    if frame_start > 1:
        trp_seg_start_dir = os.path.join(output_seg_dir, "VOLUME_" + str(frame_start-1) + "_TO_" + str(frame_start) + "_TRP_MASK_REG.nii")
    trp_seg_start = sitk.ReadImage(trp_seg_start_dir, sitk.sitkUInt8)

    # 1. Mask bones from reference image
    trp_seg_resampled = sitk.Resample(trp_seg_start, start_frame_dynact, interpolator=sitk.sitkNearestNeighbor)

    prev_grayscale = start_frame_dynact
    prev_trp_mask = trp_seg_resampled

    # if we havent set a stop frame, we run through the number of images in the folder
    if frame_stop <= 0:
        frame_stop = len(filelist)-1
    
    # reindexes our frames so that start frame will show as previous frame, we will start registering the next frame
    frames = range(frame_start+1, frame_stop, 1)

    print(f"\n****************** METHOD SETUP COMPLETE **************************\n")
    print(f"\tFrame 1 Intensity = {start_intensity_trp}")
    print(f"\tTarget Intensity = {tolerance}")
    print(f"\tStarting Volume = {frame_start}")
    print(f"\tFrames = {frames}")

    print(f"\n*******************************************************************")
    print(f"************************* FRAME {frames[0]} *********************************")
    print(f"*******************************************************************")

    index = 0
    while index < len(frames)-1:


        ##### STEP 2: READING IN FILES FOR USE IN REGISTRATION #####
        # based on frame and iteration


        item = frames[index] # ie. frames[0] = 2 if no start frame is set

        print(f"\n****************** Attempt #{counter+1}, Counter Resets: {reset_counter} ******************\n", flush=True)
        print("Registering volume {} to volume {}".format(item-1, item), flush=True)

        # setting and printing the previous greyscale and mc1 masks based on frame and attempt number
        if (item % 18 > 0):

            # if we start from the beginning (frame 2) we will use the WBCT segmentation mask
            if item == 2:
                prev_trp_mask_dir = trp_seg_start_dir
                prev_trp_mask = trp_seg_resampled

            # otherwise, use the mask mask from the previous step
            else:
                prev_trp_mask_dir = os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-2) + "_TO_" + str(item-1) + "_TRP_MASK_REG.nii")
                prev_trp_mask = sitk.ReadImage(prev_trp_mask_dir, sitk.sitkUInt8)

            # the previous grayscale will always be the volume from the previous step
            prev_greyscale_dir = os.path.join(dynact_dir, "Volume_" + str(item-1) + "_Resampled.nii")
            prev_grayscale = sitk.ReadImage(prev_greyscale_dir, sitk.sitkFloat32)
            print(f"prev_grayscale: {"/".join(prev_greyscale_dir.split("/")[8:])}", flush=True)
            print(f"prev_mc1_mask: {"/".join(prev_trp_mask_dir.split("/")[8:])}", flush=True)

        # if it is on the 18th frame we set the previous grayscale to frame 1 and seg to the WBCTS
        else: 
            print("Reached end of full movement cycle.", flush=True)
            prev_grayscale = sitk.ReadImage(os.path.join(dynact_dir, "Volume_1_Resampled.nii"), sitk.sitkFloat32)
            prev_trp_mask = sitk.ReadImage(trp_seg, sitk.sitkUInt8)
            print("prev_grayscale:", os.path.join(dynact_dir, "Volume_1_Resampled.nii"))
            print("prev_mc1_mask:", trp_seg)

        # Get the next volume file
        current_file_path = os.path.join(dynact_dir, "Volume_" + str(item) + "_Resampled.nii")
        print("current_file_path:", "/".join(current_file_path.split("/")[8:]))
        print("Previous Frame: {}".format(item-1), flush=True)
        print("Current Frame: {}".format(item), flush=True)

        if not os.path.isfile(current_file_path):
            continue

        # Read in the next frame
        current_image = sitk.ReadImage(current_file_path, sitk.sitkFloat32)


        ##### STEP 3: IMAGE PREPROCESSING AND REGISTRATION #####


        # basically convert image to black and white based on a set intensity threshold
        current_hand_seg = sitk.BinaryThreshold(current_image, -200, 10000, 1, 0)
        prev_hand_seg = sitk.BinaryThreshold(prev_grayscale, -200, 10000, 1, 0)

        # aligns centers of both images
        tmat_hand_init = sitk.CenteredTransformInitializer(
            current_hand_seg,
            prev_hand_seg,
            sitk.Similarity3DTransform(),
            sitk.CenteredTransformInitializerFilter.GEOMETRY,
        )

        # dialate previous mask (seems to reduce edges) and resample to previous grayscale
        # what is this actually doing... i don't know
        prev_trp_mask_dilate = sitk.Resample(sitk.BinaryDilate(prev_trp_mask, (15,15,15)), 
                                 prev_grayscale, 
                                 interpolator=sitk.sitkNearestNeighbor)
        prev_masked_trp = mask_bone(prev_grayscale, prev_trp_mask_dilate)

        # Multiprocess the MC1 and TRP for each frame to speed things up
        print("Registering TRP volume {} to volume {}".format(item-1, item), flush=True)

        metric = 'MeanSquares'
        optimizer = optimizers.get(optimizer_index)
        interpolator = interpolators.get(interpolator_index)

        # if its the first iteration in a set of attempts, run registration with no pref_tfm
        if counter == 0:
            print("prev_tfm: None")
            register_multiprocess("TRP", item, prev_trp_mask, current_image, prev_masked_trp, 
                              tmat_hand_init, output_seg_dir, output_tmat_dir, metric=metric, optimizer=optimizer, interpolator=interpolator)
        
        # otherwise, use the transformation from the previous attempt as a parameter in this registration
        else:
            prev_tfm_dir = os.path.join(output_dir, "FinalTFMs/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_TRP_REG.tfm")
            prev_tfm = sitk.ReadTransform(prev_tfm_dir)
            print("prev_tfm:", "/".join(prev_tfm_dir.split("/")[8:]))
            register_multiprocess("TRP", item, prev_trp_mask, current_image, prev_masked_trp, 
                                tmat_hand_init, output_seg_dir, output_tmat_dir, prev_tfm, metric, optimizer, interpolator)


        prev_grayscale = current_image
        prev_trp_mask = sitk.ReadImage(os.path.join(output_dir, "RegisteredMasks/VOLUME_" + str(item-1) + "_TO_" + str(item) + "_TRP_MASK_REG.nii"), sitk.sitkUInt8)


        # Check the mean intensity and compare to "gold standard" (i.e., frame #1)
        # Once again, I think what this crops the grayscale (which is the current image now...) to only show the bone in question
        # that way we can accurately compare average intensity
        mask = bounding_box(prev_trp_mask, 1, 1)
        prev_grayscale = sitk.Resample(prev_grayscale, mask)
        mask = sitk.Resample(mask[:,:,0:int(mask.GetSize()[2]*0.75)], mask)
        prev_grayscale = sitk.Mask(prev_grayscale, mask)
        new_intensity_trp = ((sitk.GetArrayFromImage(prev_grayscale)[(sitk.GetArrayFromImage(mask) > 0) & (np.absolute(sitk.GetArrayFromImage(prev_grayscale)) > 0)])).mean()

        print("REF TRP INTENSITY:", start_intensity_trp, flush=True)
        print("CURRENT TRP INTENSITY:", new_intensity_trp, flush=True)


        ##### STEP 4: END OF LOOP CONTROL LOGIC #####


        # if we are inside the threshold, move to the next frame
        # otherwise, we try again and iterate the counter
        if isclose(start_intensity_trp, new_intensity_trp, abs_tol=tolerance):
            index += 1
            counter = 0
            reset_counter = 0
            interpolator_index = 0
            optimizer_index = 0
            print("Success! Moving to next frame...")

            print(f"\n*******************************************************************")
            print(f"************************* FRAME {item + 1} *********************************")
            print(f"*******************************************************************")

        else:
            if item == 2:
                print("Can't get a good initial alignment at frame 1. Exiting...", flush=True)
                sys.exit()
            else:
                print("Trying again...", flush=True)
                counter += 1

        # if the counter iterates past our arbitrary max, we rest it to 0 and iterate the reset counter
        if counter >= max_counter:
            counter = 0
            reset_counter += 1

            if interpolator_index < len(interpolators) - 1:
                interpolator_index +=1
            else:
                interpolator_index = 0

                if optimizer_index < len(optimizers) - 1:
                    optimizer_index +=1
                else:
                    optimizer_index = 0

        # if we go through 5 sets of resets, we give up
        if reset_counter >= max_reset:
            print(f"Error: Cannot compute adequate alignment. {max_reset} reset attempts failed. Exiting...", flush=True)
            sys.exit()

    # while loop end        


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
    p1.join() 

    # p2.start() 
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
