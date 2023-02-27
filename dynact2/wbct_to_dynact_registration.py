"""
wbct_to_dynact_registration.py

Created by:   Michael Kuczynski
Created on:   2023.01.10

Description: Performs intensity based image registration to move WBCT images to
                the DYNACT image space. Initialization is performed using the output
                transformation matrix output from manual alignment in ITK-SNAP and
                a mutual information metric is used. 
"""

import os
import sys
import argparse
import SimpleITK as sitk


def command_iteration(method):
    """
    Prints the registration metric value during image registration.

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


def initialize_registration(itk_tfm_file):
    """
    Initialize the registration using the transformation matrix output from
    ITK-SNAP. The transformation is a text file containing an ITK style
    transformation matrix.

    Parameters
    ----------
    itk_tfm_file : string

    Returns
    -------
    ref_transform : SimpleITK.TFM
    """
    # Initialize transforms
    print("Getting initial transform")
    ref_transform = sitk.ReadTransform(itk_tfm_file)

    # For debugging
    # sitk.WriteImage(sitk.Resample(moving_image, fixed_image,
    # 								ref_transform,
    # 								sitk.sitkLinear, 0.0,
    # 								moving_image.GetPixelID()),
    # 								moving_image_registered_path)
    return ref_transform


def image_registration(fixed_img, moving_img, ref_transform):
    """
    Function to perform the image registration.

    Parameters
    ----------
    fixed_image : SimpleITK.Image

    moving_image : SimpleITK.Image

    ref_transform : SimpleITK.TFM

    Returns
    -------
    final_transform : SimpleITK.TFM
    """
    # Set up registration
    reg = sitk.ImageRegistrationMethod()

    # Similarity metric settings:
    reg.SetMetricAsMattesMutualInformation(numberOfHistogramBins=50)
    reg.SetMetricSamplingStrategy(reg.RANDOM)
    # reg.SetMetricSamplingPercentage(0.01)
    reg.SetMetricSamplingPercentagePerLevel([0.01, 0.001], 0)

    # Set Interpolator
    reg.SetInterpolator(sitk.sitkLinear)

    # Optimizer settings.
    reg.SetOptimizerAsPowell(numberOfIterations=150, valueTolerance=1e-18)
    reg.SetOptimizerScalesFromPhysicalShift()

    # Setup for the multi-resolution framework.
    reg.SetShrinkFactorsPerLevel(shrinkFactors=[2, 1])
    reg.SetSmoothingSigmasPerLevel(smoothingSigmas=[1, 0])
    reg.SmoothingSigmasAreSpecifiedInPhysicalUnitsOn()

    reg.AddCommand(sitk.sitkIterationEvent, lambda: command_iteration(reg))

    # Perform the registration
    # Don't optimize in-place, we would possibly like to run this cell multiple times.
    reg.SetInitialTransform(ref_transform, inPlace=False)
    print("Start registration")

    # registration.Execute(fixedImage, movingImage)
    final_transform = reg.Execute(fixed_img, moving_img)
    print("Final metric value: {0}".format(reg.GetMetricValue()))
    print(
        "Optimizer's stopping condition, {0}".format(
            reg.GetOptimizerStopConditionDescription()
        )
    )

    return final_transform


def main(fixed_img_path, moving_img_path, init_tfm_path):
    """
    Main function to start the registration process.

    Parameters
    ----------
    fixed_img_path : string

    moving_img_path : string

    init_tfm_path : string

    Returns
    -------
    moving_resampled : SimpleITK.Image
    """
    # Read images
    print("Reading in {}".format(fixed_img_path))
    fixed_img = sitk.ReadImage(fixed_img_path, sitk.sitkFloat64)

    print("Reading in {}".format(moving_img_path))
    moving_img = sitk.ReadImage(moving_img_path, sitk.sitkFloat64)

    # For some reason, reading in ITK-style transfroms from ITK-SNAP in SimpleITK
    # creates a composite transform. But this composite transform only has one
    # transform in it... So we can just extract it.
    t = sitk.ReadTransform(init_tfm_path)
    tx = sitk.CompositeTransform(t)
    tfm = tx.GetNthTransform(0)

    # Perform landmark transformation
    ref_transform = tfm  # initialize_registration(init_tfm_path)

    # Setup registration method
    final_transform = image_registration(fixed_img, moving_img, ref_transform)
    t = sitk.CompositeTransform(final_transform)
    final_transform = t.GetNthTransform(0)

    # print("Writing to {}".format(moving_img_tmat_path))
    # sitk.WriteTransform(final_transform, moving_img_tmat_path)

    # Resample and write registered image
    print("Resampling")
    # sitk.Resample(imageToBeResampled, referenceImage, transformation, \
    # 				interpolator, defaultPixelValue, outputPixelType)
    moving_resampled = sitk.Resample(
        moving_img,
        fixed_img,
        final_transform,
        sitk.sitkLinear,
        0.0,
        moving_img.GetPixelID(),
    )

    return moving_resampled, final_transform


if __name__ == "__main__":
    # Parse input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "fixed_img_path", type=str, help="The fixed image (path + filename)"
    )
    parser.add_argument(
        "moving_img_path", type=str, help="The moving image (path + filename)"
    )
    parser.add_argument(
        "init_tfm_path",
        type=str,
        help="The initial transformation file (path + filename)",
    )
    parser.add_argument(
        "study_id",
        nargs="?",
        type=str,
        default=None,
    )
    parser.add_argument(
        "output_path",
        nargs="?",
        type=str,
        help="The directory for any outputs",
        default=os.getcwd(),
    )
    args = parser.parse_args()

    fixed_img_path = args.fixed_img_path
    moving_img_path = args.moving_img_path
    init_tfm_path = args.init_tfm_path
    study_id = args.study_id
    output_path = args.output_path

    if study_id is None:
        moving_img_registered_path = os.path.join(output_path, "WBCT_TO_DYNACT_REG.nii")
        moving_img_tmat_path = os.path.join(output_path, "WBCT_TO_DYNACT_REG.tfm")
    else:
        moving_img_registered_path = os.path.join(output_path, study_id + "_WBCT_TO_DYNACT_REG.nii")
        moving_img_tmat_path = os.path.join(output_path, study_id + "_WBCT_TO_DYNACT_REG.tfm")

    moving_resampled, final_transform = main(fixed_img_path, moving_img_path, init_tfm_path)

    print("Writing to {}".format(moving_img_registered_path))
    sitk.WriteImage(moving_resampled, moving_img_registered_path)
    sitk.WriteTransform(final_transform, moving_img_tmat_path)
