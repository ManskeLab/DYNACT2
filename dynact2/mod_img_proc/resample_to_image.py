# -----------------------------------------------------
# resampleToImage.py
#
# Created by:   Michael Kuczynski
# Created on:   06-07-2020
#
# Description: Resamples image #1 to match information in image #2.
#              Information to match includes:
#                   -Spacing
#                   -Size
#                   -Direction
# -----------------------------------------------------
# Usage:
#   python resampleToImage.py <inputImage.ext> <referenceImage.ext>
# -----------------------------------------------------

import os
import sys
import argparse
import SimpleITK as sitk

# Read in the input arguements
parser = argparse.ArgumentParser(
    description="Resample an image based on another image using SimpleITK"
)
parser.add_argument("inputImage", help="The file path of the image to be resampled")
parser.add_argument("refImage", help="The file path of the reference image")
args = parser.parse_args()

# Parse arguments
inputImage = args.inputImage
refImage = args.refImage

inputPathAbs = os.path.abspath(inputImage)
refPathAbs = os.path.abspath(refImage)

image = sitk.ReadImage(inputPathAbs)
imageSize = image.GetSize()
imageOrigin = image.GetOrigin()
imageSpacing = image.GetSpacing()
imageDirection = image.GetDirection()
imageDataType = image.GetPixelID()

refImage = sitk.ReadImage(refPathAbs)
refImageSize = refImage.GetSize()
refImageOrigin = refImage.GetOrigin()
refImageSpacing = refImage.GetSpacing()
refImageDirection = refImage.GetDirection()
refImageDataType = refImage.GetPixelID()

# Check optional arguements
sitkInterpolator = sitk.sitkLinear


# Print some information about the image
print()
print("*******************************************************")
print("Input Image Information:")
print("Dimensions:  " + str(imageSize))
print("Spacing:     " + str(imageSpacing))
print("Origin:      " + str(imageOrigin))
print("Direction:   " + str(imageDirection))
print("Data Type:   " + image.GetPixelIDTypeAsString())
print("*******************************************************")
print("Resampled Image Information:")
print("Dimensions:   " + str(refImageSize))
print("Spacing:      " + str(refImageSpacing))
print("Origin:       " + str(refImageOrigin))
print("Direction:    " + str(refImageDirection))
print("Data Type:    " + str(refImageDataType))
print("Interpolator: sitkLinear")
print("*******************************************************")
print()

# Resample the image
print("** Resampling...")
resampleFilter = sitk.ResampleImageFilter()
resampleFilter.SetReferenceImage(refImage)
resampleFilter.SetInterpolator(sitkInterpolator)
resampleFilter.SetOutputPixelType(refImageDataType)

# Print resampling progress
resampleFilter.AddCommand(
    sitk.sitkProgressEvent,
    lambda: print(
        "\rProgress: {0:03.1f}%...".format(100 * resampleFilter.GetProgress()), end=""
    ),
)
resampleFilter.AddCommand(sitk.sitkProgressEvent, lambda: sys.stdout.flush())

resampledImage = resampleFilter.Execute(image)

print("Done!")

print("*******************************************************")
print("Resample Information:")
print(resampleFilter)
print("*******************************************************")
print()

# Write out the resampled image
resampled_path = os.path.splitext(inputPathAbs)[0]
resampled_path = resampled_path + "_RESAMPLED.nii"

print("Writing resampled image to: " + str(resampled_path))
sitk.WriteImage(resampledImage, resampled_path)
