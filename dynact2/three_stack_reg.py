# -----------------------------------------------------
# threeStackReg.py
#
# Created by: Michael Kuczynski
# Created on: July 18, 2022
#
# Description: Perform stack registration of 3 XCT images with a 25% overlap between stacks.
#              Overlap is assumed to be in the axial direction and is fixed to 42 slices.
#              Each stack is 168 axial slices, and the overlap between stacks is always 42
#               slices, even if the image was cropped to be less than 168 axial slices.
#              First, an initial alignment of images is obtained by matching geometric centres.
#              Final image alignment is obtained by optimizing the mutual information.
# -----------------------------------------------------
# Usage:
#   python stackReg.py topStack midStack bottomStack
# -----------------------------------------------------
import os
import sys
import argparse
import SimpleITK as sitk


def command_iteration(method):
    """
    Funtion to print out registration data to terminal.
    """
    print(
        "{0:3} = {1:10.5f} : {2}".format(
            method.GetOptimizerIteration(),
            method.GetMetricValue(),
            method.GetOptimizerPosition(),
        )
    )


def cropImage(image, ROISize, ROIStart):
    """
    Crops an image given the size of the ROI to crop and where the ROI starts.
    """
    crop = sitk.RegionOfInterest(image, ROISize, ROIStart)
    return crop


def cropAndInitializeReg(fixedImage, movingImage):
    """
    Aligns the fixed and moving images using the geometric centre of each image. The initial transform and
    resampled moving image are returned as outputs.
    """
    initalTFM = sitk.CenteredTransformInitializer(
        fixedImage,
        movingImage,
        sitk.Euler3DTransform(),
        sitk.CenteredTransformInitializerFilter.GEOMETRY,
    )

    movingImageResampled = sitk.Resample(
        movingImage,
        fixedImage,
        initalTFM,
        sitk.sitkBSpline,
        0.0,
        movingImage.GetPixelID(),
    )

    return initalTFM, movingImageResampled


def registerStacks(fixedImage, movingImage, initialTMAT, side):
    """
    Perform intensity-based image registration between two images.
    """
    reg = sitk.ImageRegistrationMethod()

    # Similarity metric settings
    # Use a fixed seed point for random image sampling for reproducible results
    # reg.SetMetricAsMattesMutualInformation(numberOfHistogramBins=50)
    reg.SetMetricAsMeanSquares()
    # reg.SetMetricAsCorrelation()
    reg.SetMetricSamplingStrategy(reg.RANDOM)
    # reg.SetMetricSamplingPercentage(0.01, 0)
    reg.SetMetricSamplingPercentagePerLevel([0.5, 0.25, 0.01], 0)
    # reg.SetMetricSamplingPercentagePerLevel([0.1, 0.1, 0.1], 0)

    reg.SetInterpolator(sitk.sitkBSpline)

    # Optimizer settings
    reg.SetOptimizerAsGradientDescent(
        learningRate=0.1,
        numberOfIterations=150,
        convergenceMinimumValue=1e-6,
        convergenceWindowSize=20,
    )
    reg.SetOptimizerScalesFromPhysicalShift()

    # if side == 'top':
    #   maskDST = sitk.ReadImage('/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_HRpQCT/DYNACT2_204_CMC_DST_MASK.nii')
    #   reg.SetMetricMovingMask(maskDST)
    # else:
    #   maskPRX = sitk.ReadImage('/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_HRpQCT/DYNACT2_204_CMC_PRX_MASK.nii')
    #   reg.SetMetricMovingMask(maskPRX)
    # maskMID = sitk.ReadImage('/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_HRpQCT/DYNACT2_204_CMC_MID_MASK.nii')
    # reg.SetMetricFixedMask(maskMID)

    # Setup for the multi-resolution framework
    reg.SetShrinkFactorsPerLevel(shrinkFactors=[4, 2, 1])
    reg.SetSmoothingSigmasPerLevel(smoothingSigmas=[2, 1, 0])
    reg.SmoothingSigmasAreSpecifiedInPhysicalUnitsOn()

    reg.SetInitialTransform(initialTMAT, inPlace=False)

    reg.AddCommand(sitk.sitkIterationEvent, lambda: command_iteration(reg))

    finalTMAT = reg.Execute(fixedImage, movingImage)

    print("Final metric value: {0}".format(reg.GetMetricValue()))
    print(
        "Optimizer's stopping condition, {0}".format(
            reg.GetOptimizerStopConditionDescription()
        )
    )

    return finalTMAT


def resampleFullExtent(image, tmat):
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
        tmat,
        sitk.sitkBSpline,
        outputOrigin,
        outputSpacing,
        outputDirection,
    )

    return resampledImage


def threeStackReg(topStackImage, midStackImage, bottomStackImage, outputDirectory):
    """
    Run the full stack registration workflow.
    """
    # -------------------------------------------------------------------#
    #   STEP 1: Create the output paths
    # -------------------------------------------------------------------#
    # Cropped overlap images
    topOverlapPath = os.path.join(
        outputDirectory, "TOP_MID_OVERLAP.nii"
    )  # Top-Middle Overlap
    midTopOverlapPath = os.path.join(
        outputDirectory, "MID_TOP_OVERLAP.nii"
    )  # Middle-Top Overlap
    midBottomOverlapPath = os.path.join(
        outputDirectory, "MID_BTM_OVERLAP.nii"
    )  # Middle-Bottom Overlap
    bottomOverlapPath = os.path.join(
        outputDirectory, "BTM_MID_OVERLAP.nii"
    )  # Bottom-Middle Overlap

    # Transformation matrix outputs
    topToMidInitialTMATPath = os.path.join(outputDirectory, "TOP_TO_MID_INITAL_REG.tfm")
    bottomToMidInitialTMATPath = os.path.join(
        outputDirectory, "BTM_TO_MID_INITAL_REG.tfm"
    )
    topToMidFinalTMATPath = os.path.join(outputDirectory, "TOP_TO_MID_FINAL_REG.tfm")
    bottomToMidFinalTMATPath = os.path.join(outputDirectory, "BTM_TO_MID_FINAL_REG.tfm")

    # Image masks
    topRegMaskPath = os.path.join(outputDirectory, "TOP_REG_MASK.nii")
    bottomMaskPath = os.path.join(outputDirectory, "BOTTOM_REG_MASK.nii")
    midMaskPath = os.path.join(outputDirectory, "MID_MASK.nii")

    # Registered output images
    topToMidRegPath = os.path.join(outputDirectory, "TOP_TO_MID_REG.nii")
    bottomToMidRegPath = os.path.join(outputDirectory, "BTM_TO_MID_REG.nii")

    fullImagePath = os.path.join(outputDirectory, "FULL_IMAGE.nii")

    # -------------------------------------------------------------------#
    #   STEP 2: Create the fixed and moving images
    # -------------------------------------------------------------------#
    # Crop overlap regions
    # Registration #1: Top to Middle
    # Set the middle image as fixed, and the top as moving
    fixedImage1 = cropImage(
        midStackImage,
        [midStackImage.GetWidth(), midStackImage.GetHeight(), 42],
        [0, 0, midStackImage.GetDepth() - 42],
    )
    movingImage1 = cropImage(
        topStackImage,
        [topStackImage.GetWidth(), topStackImage.GetHeight(), 42],
        [0, 0, 0],
    )

    sitk.WriteImage(fixedImage1, midTopOverlapPath)
    sitk.WriteImage(movingImage1, topOverlapPath)

    topToMidInitialTMAT, movingImageResampled1 = cropAndInitializeReg(
        fixedImage1, movingImage1
    )
    sitk.WriteTransform(topToMidInitialTMAT, topToMidInitialTMATPath)
    sitk.WriteImage(movingImageResampled1, topToMidRegPath)

    # Registration #2: Bottom to Middle
    # Set the middle image as fixed, and the bottom as moving
    fixedImage2 = cropImage(
        midStackImage,
        [midStackImage.GetWidth(), midStackImage.GetHeight(), 42],
        [0, 0, 0],
    )
    movingImage2 = cropImage(
        bottomStackImage,
        [bottomStackImage.GetWidth(), bottomStackImage.GetHeight(), 42],
        [0, 0, bottomStackImage.GetDepth() - 42],
    )

    sitk.WriteImage(fixedImage2, midBottomOverlapPath)
    sitk.WriteImage(movingImage2, bottomOverlapPath)

    bottomToMidInitialTMAT, movingImageResampled2 = cropAndInitializeReg(
        fixedImage2, movingImage2
    )
    sitk.WriteTransform(bottomToMidInitialTMAT, bottomToMidInitialTMATPath)
    sitk.WriteImage(movingImageResampled2, bottomToMidRegPath)

    # -------------------------------------------------------------------#
    #   STEP 3: Register top stack to bottom stack
    # -------------------------------------------------------------------#
    # Run the registration
    # Registration #1: Top to Middle
    topToMidFinalTMAT = registerStacks(
        fixedImage1, movingImage1, topToMidInitialTMAT, "top"
    )
    sitk.WriteTransform(topToMidFinalTMAT, topToMidFinalTMATPath)

    # Registration #2: Bottom to Middle
    bottomToMidFinalTMAT = registerStacks(
        fixedImage2, movingImage2, bottomToMidInitialTMAT, "bottom"
    )
    sitk.WriteTransform(bottomToMidFinalTMAT, bottomToMidFinalTMATPath)

    # -------------------------------------------------------------------#
    #   STEP 4: Transform and resample the moving images
    # -------------------------------------------------------------------#
    # Make sure we keep the full extent of the transformed images

    # Registration #1: Top Image
    regTopImage = resampleFullExtent(topStackImage, topToMidFinalTMAT)
    sitk.WriteImage(regTopImage, topToMidRegPath)

    # Registration #2: Bottom Image
    regBottomImage = resampleFullExtent(bottomStackImage, bottomToMidFinalTMAT)
    sitk.WriteImage(regBottomImage, bottomToMidRegPath)

    # -------------------------------------------------------------------#
    #   STEP 5: Create an empty image and paste in the bottom stack
    # -------------------------------------------------------------------#
    width = (
        max(
            midStackImage.GetSize()[0],
            regTopImage.GetSize()[0],
            regBottomImage.GetSize()[0],
        )
        + 50
    )
    height = (
        max(
            midStackImage.GetSize()[1],
            regTopImage.GetSize()[1],
            regBottomImage.GetSize()[1],
        )
        + 50
    )
    depth = (
        midStackImage.GetSize()[2]
        + regTopImage.GetSize()[2]
        + regBottomImage.GetSize()[2]
        - 42
        - 42
    )

    originX = min(
        regTopImage.GetOrigin()[0],
        midStackImage.GetOrigin()[0],
        regBottomImage.GetOrigin()[0],
    )
    originY = min(
        regTopImage.GetOrigin()[1],
        midStackImage.GetOrigin()[1],
        regBottomImage.GetOrigin()[1],
    )
    originZ = min(
        regTopImage.GetOrigin()[2],
        midStackImage.GetOrigin()[2],
        regBottomImage.GetOrigin()[2],
    )

    finalImageOrigin = [originX, originY, originZ]
    finalImageDim = [width, height, depth]

    finalImage = sitk.Image(finalImageDim, sitk.sitkFloat32)
    finalImage.SetOrigin(finalImageOrigin)
    finalImage.SetSpacing(midStackImage.GetSpacing())
    finalImage.SetDirection(midStackImage.GetDirection())

    # Get the index where our mid stack image will be pasted
    # This needs to be in  image index coordinates, not physical image
    # coordinates (i.e., mm or um)
    destIndexX = abs(
        finalImage.TransformPhysicalPointToIndex(finalImageOrigin)[0]
        - finalImage.TransformPhysicalPointToIndex(midStackImage.GetOrigin())[0]
    )
    destIndexY = abs(
        finalImage.TransformPhysicalPointToIndex(finalImageOrigin)[1]
        - finalImage.TransformPhysicalPointToIndex(midStackImage.GetOrigin())[1]
    )
    destIndexZ = abs(
        finalImage.TransformPhysicalPointToIndex(finalImageOrigin)[2]
        - finalImage.TransformPhysicalPointToIndex(midStackImage.GetOrigin())[2]
    )
    midDestIndex = [destIndexX, destIndexY, destIndexZ]

    pastedImg = sitk.Paste(
        finalImage,
        midStackImage,
        midStackImage.GetSize(),
        destinationIndex=midDestIndex,
    )

    # -------------------------------------------------------------------#
    #   STEP 6: Create a mask of each bone
    # -------------------------------------------------------------------#
    # Get the mask of each bone (assuming background is 0)
    # Use morphological closing to account for voxels in the bone that equal 0
    topMask = sitk.Cast(regTopImage, sitk.sitkInt8) != 0
    topMask = sitk.BinaryMorphologicalClosing(topMask, (3, 3, 1))

    midMask = sitk.Cast(pastedImg, sitk.sitkInt8) != 0
    midMask = sitk.BinaryMorphologicalClosing(midMask, (3, 3, 1))

    bottomMask = sitk.Cast(regBottomImage, sitk.sitkInt8) != 0
    bottomMask = sitk.BinaryMorphologicalClosing(bottomMask, (3, 3, 1))

    # Resample the top and bottom masks so they has the same dimensions as the
    # mid mask
    topMask = sitk.Resample(topMask, pastedImg, interpolator=sitk.sitkNearestNeighbor)
    bottomMask = sitk.Resample(
        bottomMask, pastedImg, interpolator=sitk.sitkNearestNeighbor
    )

    # Create a mask for the top and bottom images that does not include the overlap
    # with the mid image
    topCombinedMask = topMask - (topMask & midMask)
    bottomCombinedMask = bottomMask - (bottomMask & midMask)

    sitk.WriteImage(topMask, topRegMaskPath)
    sitk.WriteImage(midMask, midMaskPath)
    sitk.WriteImage(bottomMask, bottomMaskPath)

    # -------------------------------------------------------------------#
    #   STEP 7: Add images together
    # -------------------------------------------------------------------#
    # Resample the transformed top stack image to have the same dimensions
    # as the bottom stack image so we can do a simple addition
    regTopImage = sitk.Resample(regTopImage, pastedImg, interpolator=sitk.sitkBSpline)
    regBottomImage = sitk.Resample(
        regBottomImage, pastedImg, interpolator=sitk.sitkBSpline
    )

    # Mask out the top and bottom stack images (without the overlap)
    maskedRegTop = sitk.Mask(regTopImage, topCombinedMask, 0, 0)
    maskedRegBottom = sitk.Mask(regBottomImage, bottomCombinedMask, 0, 0)

    pastedImg = pastedImg + maskedRegTop + maskedRegBottom

    sitk.WriteImage(pastedImg, fullImagePath)


if __name__ == "__main__":
    # Parse input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("topStack", type=str, help="Top stack image (path + filename)")
    parser.add_argument(
        "midStack", type=str, help="Middle stack image (path + filename)"
    )
    parser.add_argument(
        "bottomStack", type=str, help="Bottom stack image (path + filename)"
    )
    args = parser.parse_args()

    topStackPath = args.topStack
    midStackPath = args.midStack
    bottomStackPath = args.bottomStack

    # Get the filename from the path
    topStackBaseName = (os.path.basename(topStackPath)).lower()
    midStackBaseName = (os.path.basename(midStackPath)).lower()
    bottomStackBaseName = (os.path.basename(bottomStackPath)).lower()

    # Only accept MHA and NII images
    if not (".mha" in topStackBaseName or ".nii" in topStackBaseName):
        sys.exit(
            "Wrong file type for the top stack. Only MHA and NII images will be accepted."
        )
    elif not (".mha" in bottomStackBaseName or ".nii" in bottomStackBaseName):
        sys.exit(
            "Wrong file type for the bottom stack. Only MHA and NII images will be accepted."
        )
    elif not (".mha" in midStackBaseName or ".nii" in midStackBaseName):
        sys.exit(
            "Wrong file type for the middle stack. Only MHA and NII images will be accepted."
        )

    # Create a new folder to hold the output images
    imageDirectory = os.path.dirname(bottomStackPath)
    outputDirectory = os.path.join(imageDirectory, "stack_reg_output")

    # Check if the directory already exists
    if not os.path.isdir(outputDirectory):
        print("Creating output directory {}".format(outputDirectory))
        os.mkdir(outputDirectory)

    # Read in images as floats to increase precision
    topImage = sitk.ReadImage(topStackPath, sitk.sitkFloat32)
    midImage = sitk.ReadImage(midStackPath, sitk.sitkFloat32)
    bottomImage = sitk.ReadImage(bottomStackPath, sitk.sitkFloat32)

    threeStackReg(topImage, midImage, bottomImage, outputDirectory)
