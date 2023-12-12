import os
import argparse
import SimpleITK as sitk

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Crop a mask using SimpleITK")
    parser.add_argument("mask_path", help="The mask image file path")
    args = parser.parse_args()

    mask_path = args.mask_path

    mask = sitk.ReadImage(mask_path, sitk.sitkUInt8)

    thresh = sitk.BinaryThresholdImageFilter()
    thresh.SetLowerThreshold(1)
    thresh.SetUpperThreshold(255)
    thresh.SetOutsideValue(0)
    thresh.SetInsideValue(1)
    thresh_img = thresh.Execute(mask)

    sitk.WriteImage(thresh_img, os.path.join(os.path.dirname(mask_path), os.path.basename(mask_path)))