import SimpleITK as sitk
import os
import numpy as np
import argparse
import errno
import logging

from math import isclose
from bounding_box_quad import bounding_box

def registration(initial_transform, fixed_image, moving_image, moving_image_mask, sampling_percentage):
    """
    Initializes and executes registration

    Parameters
    ----------
    initial_transform (sitk.Transform) : initialization transform (generally hand segment match)

    fixed_image (sitk.Image) : fixed image for registration (generally current dynact frame)

    moving_image (sit.Image) : moving image for registration (generally the first dynact frame)

    moving_image_mask (sitk.Image) : mask of features in moving image to be registered (generally frame 1 dilated mask)

    sampling_percentage (double) : sampling percentage to be used in registration

    Returns
    -------
    final_transform (sitk.Transform) : final transform produced from registration execution

    """
    reg = sitk.ImageRegistrationMethod()

    reg.SetMetricAsMeanSquares()
    reg.SetMetricSamplingStrategy(reg.RANDOM)
    reg.SetMetricSamplingPercentage(sampling_percentage)
    reg.SetMetricMovingMask(moving_image_mask)

    reg.SetOptimizerAsRegularStepGradientDescent(
                    learningRate=0.5,
                    minStep=1e-8,
                    numberOfIterations=1000,
                    gradientMagnitudeTolerance=1e-8
                )

    reg.SetInterpolator(sitk.sitkLinear)
    reg.SetOptimizerScalesFromPhysicalShift()
    reg.SetInitialTransform(initial_transform, inPlace=False)

    final_transform = reg.Execute(fixed=fixed_image, moving=moving_image)

    return final_transform
   
def register_volumes(dynact_dir, output_segmentation_dir, output_transformation_dir, filelist, wbct_segmentation_path, frame_start=1, frame_stop=0, tolerance=0.1, bone='MC1'):
    """
    Initializes and registers images in a volume, motion, bone

    Parameters
    ----------
    dynact_dir (string) : directory or dynamic ct images

    output_segmentation_dir (string) : directory to write output segmentations

    output_transformation_dir (string) : directory to write transforms

    filelist (list(string)) : list of files in dynact directory

    wbct_segmentation_path (string) : path to wbct segmentation of specific bone, motion

    frame_start (int) : starting frame if specified 

    frame_stop (int) : stopping frame if specified

    tolerance (double) : allowed tolerance of intensity comparison

    bone (string) : bone being registered

    Returns
    -------
    none

    """
    # Logger setup
    for handler in logging.root.handlers[:]:
        logging.root.removeHandler(handler)
    logging.basicConfig(
            filename=os.path.join(dynact_dir, "logs.log"),
            format='%(message)s',
            filemode='a'
        )
    logger = logging.getLogger()


    dilation_kernel = (15, 15, 15)
    registration_sampling_percentage = 0.25
    count = 0

    # loading in dynamic ct frame 1 and wbct segmentation
    frame_1_dynact_path = os.path.join(dynact_dir, "Volume_1_Resampled.nii")
    frame_1_dynact = sitk.ReadImage(frame_1_dynact_path, sitk.sitkFloat32)
    wbct_segmentation = sitk.ReadImage(wbct_segmentation_path, sitk.sitkUInt8)

    # resampling frame 1 with wbct segmentation in preparation to calculate average intensity of image masked behind segmentation
    wbct_mask = bounding_box(wbct_segmentation, 1, 1) # cropping area of interest in WBCT segmentation
    frame_1_dynact_cropped = sitk.Resample(frame_1_dynact, wbct_mask) # resample dynamic ct frame to match cropped image dimensions
    wbct_mask_cropped = sitk.Resample(wbct_mask[:,:,0:int(wbct_mask.GetSize()[2]*0.75)], wbct_mask) # cut off top 25% of WBCT mask 
    frame_1_dynact_masked_and_cropped = sitk.Mask(frame_1_dynact_cropped, wbct_mask_cropped) # apply mask on dynamic ct frame 1

    # calcuating intensity and tolerance
    start_intensity = ((sitk.GetArrayFromImage(frame_1_dynact_masked_and_cropped)[(sitk.GetArrayFromImage(wbct_mask_cropped) > 0) & (np.absolute(sitk.GetArrayFromImage(frame_1_dynact_masked_and_cropped)) > 0)])).mean()
    tolerance = tolerance * start_intensity

    # resampling wbct segmentation onto frame 1 dynamic ct
    wbct_segmentation_resampled = sitk.Resample(wbct_segmentation, frame_1_dynact, interpolator=sitk.sitkNearestNeighbor)

    # using binary threshold to segment entire hand
    frame_1_hand_segmentation = sitk.BinaryThreshold(frame_1_dynact, -200, 10000, 1, 0)

    # dilating wbct segmentation and masking onto frame 1 for use in registration as moving_image_mask
    wbct_segmentation_dilated = sitk.Resample(sitk.BinaryDilate(wbct_segmentation_resampled, dilation_kernel), 
                            frame_1_dynact, 
                            interpolator=sitk.sitkNearestNeighbor)
    frame_1_dilated_mask = sitk.Mask(frame_1_dynact, wbct_segmentation_dilated)

    # if we havent set a stop frame, we run through the number of images in the folder
    if frame_stop <= 0:
        frame_stop = len(filelist)-1

    # reindexes our frames so that start frame will show as previous frame, we will start registering the next frame
    frames = range(frame_start+1, frame_stop, 1)

    print(f"\n****************** METHOD SETUP COMPLETE **************************\n")
    print(f"\tFrame 1 Intensity = {start_intensity}")
    print(f"\tTolerance = +/-{tolerance}")
    print(f"\tStarting Volume = {frame_start}")
    print(f"\tFrames = {frames}")

    index = 0
    while index < len(frames)-1:

        item = frames[index] # ie. frames[0] = 2 if no start frame is set
        print(f'\nFrame {item}')

        # loading in current dynact frame
        current_dynact_path = os.path.join(dynact_dir, f"Volume_{item}_Resampled.nii")
        current_dynact = sitk.ReadImage(current_dynact_path, sitk.sitkFloat32)

        # segmenting current dynact frame hand segment and initializing transformation for registration
        current_hand_segmentation = sitk.BinaryThreshold(current_dynact, -200, 10000, 1, 0)
        hand_segmentation_transformation = sitk.CenteredTransformInitializer(
                current_hand_segmentation,
                frame_1_hand_segmentation,
                sitk.Euler3DTransform(),
                sitk.CenteredTransformInitializerFilter.MOMENTS,
            )
        
        # running registration
        final_tmat = registration(
            initial_transform=hand_segmentation_transformation, 
            fixed_image=current_dynact, 
            moving_image=frame_1_dynact, 
            moving_image_mask=frame_1_dilated_mask,
            sampling_percentage=registration_sampling_percentage
            )

        # applying transformation on wbct segmentation and smoothing
        final_mask = sitk.Resample(wbct_segmentation_resampled, transform=final_tmat, interpolator=sitk.sitkNearestNeighbor)
        final_mask = sitk.BinaryMedian(final_mask, [2,2,2])

        # writing transform and transformed segmentation
        try:
            sitk.WriteImage(final_mask, os.path.join(output_segmentation_dir, f"VOLUME_1_TO_{item}_{bone}_MASK_REG.nii"))
        except Exception as e:
            print(f"ERROR: {e}")

        try:
            sitk.WriteTransform(final_tmat, os.path.join(output_transformation_dir, f"VOLUME_1_TO_{item}_{bone}_REG.tfm"))
        except Exception as e:
            print(f"ERROR: {e}")

        # resampling current dynamic ct frame with transformed segmentation to calculate average intensity under the mask
        transformed_mask = bounding_box(final_mask, 1, 1) # cropping transformed segmentation to area of interest
        current_dynact_frame_cropped = sitk.Resample(current_dynact, transformed_mask) # cropping current grayscale to transformed segmentation dimensions
        transformed_mask_cropped = sitk.Resample(transformed_mask[:,:,0:int(transformed_mask.GetSize()[2]*0.75)], transformed_mask) # removing top 25% of segmentation            
        current_dynact_frame_cropped_and_masked = sitk.Mask(current_dynact_frame_cropped, transformed_mask_cropped) # applying mask on current dynamic ct with transformed segmentation

        # calcuating new intensity
        new_intensity = ((sitk.GetArrayFromImage(current_dynact_frame_cropped_and_masked)[(sitk.GetArrayFromImage(transformed_mask_cropped) > 0) & (np.absolute(sitk.GetArrayFromImage(current_dynact_frame_cropped_and_masked)) > 0)])).mean()
        print("FRAME 1 INTENSITY:", start_intensity)
        print("CURRENT INTENSITY:", new_intensity)

        # if we are inside the threshold, move to the next frame
        # otherwise, we try again and iterate the counter
        if isclose(start_intensity, new_intensity, abs_tol=tolerance):
            print("Success! Logging result and moving to next frame...")
            logger.warning(f"Frame {item}: Success, {start_intensity}, {new_intensity}, {registration_sampling_percentage}")
            index += 1

        else:
            if count < 3:
                print("Unsuccessful registration. Increasing sampling percentage and trying again...")
                logger.warning(f"Frame {item}: Failure, {start_intensity}, {new_intensity}, {registration_sampling_percentage}")
                count += 1
                registration_sampling_percentage += 0.25
            else:
                print("Unsuccessful registration. Logging result and moving to next frame...")
                logger.warning(f"Frame {item}: Failure, {start_intensity}, {new_intensity}, {registration_sampling_percentage}")
                count = 0
                index += 1
                registration_sampling_percentage = 0.25


    # while loop end        

def main(models_dir, model, motion, frame_start, bone):
    """
    Main function to perform the sequential image registration.

    Parameters
    ----------
    models_dir (string) : directory to all dynact models

    model (int) : desired model to perform registration on

    motion (string) : desired motion to register (all motions registered if none specified)

    frame_start (int) : desired frame to start registering (will start on frame 1 if none specified)

    bone (string) : desired bone to register (registers both bones if none specified)

    Returns
    -------
    none

    """

    model_dir = os.path.join(models_dir, f"DYNACT2_{model}")

    bone = 'MC1'
    
    if motion == None:
        motions = ['ABAD', 'KEY', 'OPP']
    else:
        motions = [motion]

    for m in motions:
        print(f"\n******Model: {model}, Bone: {bone}, Motion: {m}******")
        motion_dir = os.path.join(model_dir, f"DYNACT2_{model}_{m}")
        dynact_dir = os.path.join(motion_dir, "RESAMPLED")
        output_dir = os.path.join(motion_dir, "REGISTRATION")
        
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
        filelist = os.path.join(dynact_dir, '*Volume_*_Resampled.nii')

        wbct_seg_dir = os.path.join(model_dir, f"DYNACT2_{model}_WBCT")
        wbct_seg = os.path.join(wbct_seg_dir, f"DYNACT2_{model}_WBCT_CROP_PERI_MC1_BB_REORIENT_{m}_TRANSF.nii")

        register_volumes(
                dynact_dir=dynact_dir, 
                output_segmentation_dir=output_seg_dir, 
                output_transformation_dir=output_tmat_dir, 
                filelist=filelist, 
                wbct_segmentation_path=wbct_seg, 
                frame_stop=27, 
                tolerance=0.1,
                bone=bone
            )
    
if __name__ == "__main__":
    # Parse input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("model_dir", type=str)
    parser.add_argument("-model", dest="model", type=int, default=204)

    # optional arguments
    parser.add_argument("-motion", dest="motion", type=str, default=None)
    parser.add_argument("-bone", dest="bone", type=str, default=None)
    parser.add_argument("-start", dest="frame_start", type=int, default=None)

    args = parser.parse_args()
    model_dir = args.model_dir
    model = args.model
    motion = args.motion
    bone = args.bone
    frame_start = args.frame_start

    main(
            models_dir=model_dir,
            model=model,
            motion=motion,
            frame_start=frame_start, 
            bone=bone
        )