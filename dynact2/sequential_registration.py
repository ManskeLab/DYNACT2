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
import SimpleITK as sitk


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
        sitk.Euler3DTransform(),
        sitk.CenteredTransformInitializerFilter.MOMENTS,
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
    reg.SetMetricAsMeanSquares()
    reg.SetMetricSamplingStrategy(reg.RANDOM)
    reg.SetMetricSamplingPercentage(0.01)
    reg.SetInterpolator(sitk.sitkLinear)
    reg.SetOptimizerAsPowell(numberOfIterations=150, valueTolerance=1e-10)
    reg.SetOptimizerScalesFromPhysicalShift()
    reg.SetShrinkFactorsPerLevel(shrinkFactors=[4, 2, 1])
    reg.SetSmoothingSigmasPerLevel(smoothingSigmas=[2, 1, 0])
    reg.SmoothingSigmasAreSpecifiedInPhysicalUnitsOn()
    reg.SetInitialTransform(init_tmat, inPlace=False)

    # FORMAT: registration.Execute(fixedImage, movingImage)
    final_tmat = reg.Execute(fixed, moving)

    return final_tmat


def register_multiprocess(bone, volume_num, bone_seg_ref, grayscale_volume, 
                          masked_bone, hand_tfm, output_dir):
    bone = str(bone).upper()
    bb_seg_next = sitk.Resample(bone_seg_ref, grayscale_volume, 
                                transform=hand_tfm, 
                                interpolator=sitk.sitkNearestNeighbor)
   
    # Dilate the transformed bone mask to ensure we capture the bone
    bb_seg_next_dilate = sitk.BinaryDilate(bb_seg_next, (9,9,9))
    masked_next = mask_bone(grayscale_volume, bb_seg_next_dilate)

    init_tfm = initialize_tfm(masked_next, masked_bone)

    print("Running registration...")
    final_tfm = registration(init_tfm, masked_next, masked_bone)

    final_image = sitk.Resample(masked_bone, grayscale_volume, transform=final_tfm)
    final_mask = sitk.Resample(bone_seg_ref, grayscale_volume, transform=final_tfm)

    print("Writing registered image...")
    sitk.WriteImage(final_mask, os.path.join(output_dir, "VOLUME_REF_TO_" + str(volume_num) + "_" + str(bone) + "_FULLMASK_REG.nii"))
    sitk.WriteImage(final_image, os.path.join(output_dir, "VOLUME_REF_TO_" + str(volume_num) + "_" + str(bone) + "_REG.nii"))


def main(dynact_dir, mc1_seg, trp_seg, output_dir):
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
    output_seg_dir = os.path.join(output_dir, "RegisteredMasks")

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

    # We need to process the first frame before looping through all volumes/frames
    # Read masks at frame 1
    frame_1_dynact_path = os.path.join(dynact_dir, 'Volume_1_Resampled.nii')
    print("Reading in {}".format(frame_1_dynact_path))
    frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)

    print("Reading in {}".format(mc1_seg))
    mc1_seg_ref = sitk.ReadImage(mc1_seg, sitk.sitkUInt8)
    print("Reading in {}".format(trp_seg))
    trp_seg_ref = sitk.ReadImage(trp_seg, sitk.sitkUInt8)



    # 1. Mask bones from reference image
    mc1_seg_ref_resampled = sitk.Resample(mc1_seg_ref, frame_1_dynact, interpolator=sitk.sitkNearestNeighbor)
    trp_seg_ref_resampled = sitk.Resample(trp_seg_ref, frame_1_dynact, interpolator=sitk.sitkNearestNeighbor)

    masked_ref_mc1 = mask_bone(frame_1_dynact, mc1_seg_ref_resampled)
    masked_ref_trp = mask_bone(frame_1_dynact, trp_seg_ref_resampled)

    # 2. Segment the hand from the reference image
    frame_1_dynact_hand_seg = sitk.BinaryThreshold(frame_1_dynact, 0, 255, 1, 0)

    # 3. Loop through all DYNACT frames and register the 1st volume to all others
    dynact_full_mask_list = [None] * len(filelist)
    dynact_full_mask_list[0] = [mc1_seg_ref, trp_seg_ref]

    for i in range(2, len(filelist)-1, 1):
        print("Registering reference volume to volume {}".format(i))

        # Get the next volume file
        next_file_path = os.path.join(dynact_dir, "Volume_" + str(i) + "_Resampled.nii")

        print("Reading in {}".format(next_file_path))

        if not os.path.isfile(next_file_path):
            continue

        # Get the next frame
        next_image = sitk.ReadImage(next_file_path, sitk.sitkFloat32)

        hand_seg_next = sitk.BinaryThreshold(next_image, 0, 255, 1, 0)
        tmat_hand_init = sitk.CenteredTransformInitializer(
            hand_seg_next,
            frame_1_dynact_hand_seg,
            sitk.Euler3DTransform(),
            sitk.CenteredTransformInitializerFilter.GEOMETRY,
        )

        # Multiprocess the MC1 and TRP for each frame to speed things up
        register_multiprocess("MC1", i, mc1_seg_ref_resampled, 
                                        next_image, masked_ref_mc1, 
                                        tmat_hand_init, output_seg_dir)
        register_multiprocess("TRP", i, trp_seg_ref_resampled, 
                                        next_image, masked_ref_trp, 
                                        tmat_hand_init, output_seg_dir)
        # print("Registering MC1 reference to volume {}".format(i))
        # p1 = multiprocess.Process(target=register_multiprocess, 
        #                           args=("MC1", i, mc1_seg_ref_resampled, 
        #                                 next_image, masked_ref_mc1, 
        #                                 tmat_hand_init, output_seg_dir))
        
        # print("Registering TRP reference to volume {}".format(i))
        # p2 = multiprocess.Process(target=register_multiprocess, 
        #                           args=("TRP", i, trp_seg_ref_resampled, 
        #                                 next_image, masked_ref_trp, 
        #                                 tmat_hand_init, output_seg_dir))

        # p1.start() 
        # p2.start() 

        # p1.join() 
        # p2.join() 


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
    args = parser.parse_args()

    dynact_dir = args.dynact_dir
    mc1_seg = args.mc1_seg
    trp_seg = args.trp_seg
    output_dir = args.output_dir

    main(dynact_dir, mc1_seg, trp_seg, output_dir)
