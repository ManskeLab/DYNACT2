"""
transform.py

Created by:   Michael Kuczynski
Created on:   21-02-2020

Description: Transform an image using the provided TFM file.
"""

import os
import sys
import argparse
import numpy as np
import SimpleITK as sitk


# Dictionary for interpolator types
interpolatorDict = {
    "nn": sitk.sitkNearestNeighbor,
    "linear": sitk.sitkLinear,
    "spline": sitk.sitkBSpline,
    "gaussian": sitk.sitkGaussian,
}


def resampleFullExtent(image, fixed, tmat, interp):
    """
    Resamples an input image while keeping the image's original extent.
    """
    # First get the extent of the original image
    extremePoints = [
        image.TransformIndexToPhysicalPoint((0, 0, 0)),
        image.TransformIndexToPhysicalPoint((image.GetWidth(), 0, 0)),
        image.TransformIndexToPhysicalPoint((0, image.GetHeight(), 0)),
        image.TransformIndexToPhysicalPoint((0, 0, image.GetDepth())),
        image.TransformIndexToPhysicalPoint((image.GetWidth(), image.GetHeight(), 0)),
        image.TransformIndexToPhysicalPoint((image.GetWidth(), 0, image.GetDepth())),
        image.TransformIndexToPhysicalPoint(
            (image.GetWidth(), image.GetHeight(), image.GetDepth())
        ),
        image.TransformIndexToPhysicalPoint((0, image.GetHeight(), image.GetDepth())),
    ]

    # Use the inverse transform to get the bounds of the resampling grid
    tmatInverse = tmat.GetInverse()
    extremePointsTransformed = [
        tmatInverse.TransformPoint(pnt) for pnt in extremePoints
    ]

    minX = min(extremePointsTransformed)[0]
    minY = min(extremePointsTransformed, key=lambda p: p[1])[1]
    minZ = min(extremePointsTransformed, key=lambda p: p[2])[2]
    maxX = max(extremePointsTransformed)[0]
    maxY = max(extremePointsTransformed, key=lambda p: p[1])[1]
    maxZ = max(extremePointsTransformed, key=lambda p: p[2])[2]

    outputSpacing = image.GetSpacing()
    outputDirection = image.GetDirection()
    outputOrigin = [minX, minY, minZ]

    # Compute grid size based on the physical size and spacing
    outputSize = [
        int((maxX - minX) / outputSpacing[0]),
        int((maxY - minY) / outputSpacing[1]),
        int((maxZ - minZ) / outputSpacing[2]),
    ]
    
    # Transform the image keeping the original extent
    resampledImage = sitk.Resample(
        image,
        outputSize,
        tfm,
        interp,
        outputOrigin,
        outputSpacing,
        fixed.GetDirection(),
        0.0,
        fixed.GetPixelID(),
    )

    return resampledImage


if __name__ == "__main__":
    # Parse input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("fixedImage", type=str, help="Fixed image (path + filename)")
    parser.add_argument(
        "movingImage", type=str, help="Moving image to be transformed (path + filename)"
    )
    parser.add_argument(
        "TFM", type=str, help="The transformation matrix .TFM file (path + filename)"
    )
    parser.add_argument(
        "-o",
        dest="outputFile",
        type=str,
        default="",
        help="Output image (path + filename). Default = moving image directory",
    )
    parser.add_argument(
        "-i",
        dest="interpolator",
        type=str,
        default="linear",
        help="SimpleITK interpolator type (nearestNeighbor, linear, spline, or gaussian). Default = linear",
    )
    parser.add_argument(
        "-r",
        dest="inverseTFM",
        default=False,
        help="Option to apply the inverse transform. Default = False",
    )
    args = parser.parse_args()

    fixedImage = args.fixedImage
    movingImage = args.movingImage
    TFM = args.TFM
    inverseTFM = args.inverseTFM
    outputFile = args.outputFile

    interpolator = (args.interpolator).lower()
    interpolator = interpolatorDict.get(interpolator)

    # Check file extensions
    # Images can only be .nii or .mha
    # Transformation matrix can only be .tfm
    fixedDir, fixedFilename = os.path.split(fixedImage)
    fixedBasename, fixedExtension = os.path.splitext(fixedFilename)

    movingDir, movingFilename = os.path.split(movingImage)
    movingBasename, movingExtension = os.path.splitext(movingFilename)

    tfmDir, tfmFilename = os.path.split(TFM)
    tfmBasename, tfmExtension = os.path.splitext(tfmFilename)

    if not (fixedExtension.lower() == ".mha" or fixedExtension.lower() == ".nii"):
        print()
        print(f"Error: Invalid file extension {fixedExtension} for: {fixedImage}")
        sys.exit(1)
    elif not (movingExtension.lower() == ".mha" or movingExtension.lower() == ".nii"):
        print()
        print(f"Error: Invalid file extension {movingExtension} for: {movingImage}")
        sys.exit(1)
    elif not (tfmExtension.lower() == ".tfm" or tfmExtension.lower() == ".txt"):
        print()
        print(f"Error: Invalid file extension {tfmExtension} for: {TFM}")
        sys.exit(1)

    # Make sure expected files exist
    expected_files = [fixedImage, movingImage, TFM]
    for file_name in expected_files:
        if not os.path.isfile(file_name):
            print()
            print("Error: Could not find file: ")
            print(f"{file_name}")
            sys.exit(1)

    # If no output file or directory was provided, save the transformed image
    # to the same directory as the moving image
    if not outputFile:
        # Extract directory, filename, basename, and extensions from the output
        # image
        outDirectory, outFilename = os.path.split(movingImage)
        outBasename, outExtension = os.path.splitext(outFilename)

        if "ABAD" in fixedImage:
            outputFile = os.path.join(outDirectory, outBasename + "_ABAD_TRANSF" + outExtension)
        elif "OPP" in fixedImage:
            outputFile = os.path.join(outDirectory, outBasename + "_OPP_TRANSF" + outExtension)
        elif "KEY" in fixedImage:
            outputFile = os.path.join(outDirectory, outBasename + "_KEY_TRANSF" + outExtension)
        elif "HRpQCT" in fixedImage:
            outputFile = os.path.join(outDirectory, outBasename + "_TO_XCT_TRANSF" + outExtension)
        else:
            outputFile = os.path.join(outDirectory, outBasename + "_TRANSF" + outExtension)

        print()
        print(
            "Warning: No output file name or directory provided. Writing transformed image to: "
        )
        print(f"{outputFile}")

    print()
    print(f"TRANFORMING: \n{movingImage} \nto \n{fixedImage}")

    # Read in fixed image
    print()
    print("READING: ")
    print(f"{fixedImage}")
    fixed = sitk.ReadImage(fixedImage)

    # Read in moving image
    print("READING: ")
    print(f"{movingImage}")
    moving = sitk.ReadImage(movingImage)

    # Read in the transform
    print("READING: ")
    print(f"{TFM}")
    tfm = sitk.ReadTransform(TFM)

    if inverseTFM:
        tfm = tfm.GetInverse()

    # ----------------------------------------------#
    # STEP 2: Transform the moving image
    # ----------------------------------------------#
    print()
    print("RESAMPLING: ")
    print(f"{movingImage}")
    resampled = resampleFullExtent(moving, fixed, tfm, interpolator)

    print()
    print("WRITING: ")
    print(f"{outputFile}")
    sitk.WriteImage(resampled, outputFile)
