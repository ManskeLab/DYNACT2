"""
downsample.py

Created by:   Michael Kuczynski
Created on:   2023.01.10

Description: Downsamples WBCT images to match DYNACT image spacing. 
"""

import os
import argparse
import SimpleITK as sitk


def downsample(wbct_img, dynact_img):
    """
    Downsamples an input WBCT image to match the spacing of the dynact_img

    Parameters
    ----------
    wbct_img : SimpleITK.Image
        Input WBCT image to be downsampled

    dynact_img : SimpleITK.Image
        Input DYNACT image volume to match spacing dimensions

    Returns
    -------
    resampled : SimpleITK.Image
        Resampled WBCT image
    """
    wbct_spacing = wbct_img.GetSpacing()
    dynact_spacing = dynact_img.GetSpacing()

    wbct_size = wbct_img.GetSize()

    # Formula to calculate new image dimensions:
    # newDim = oldDim * oldSpacing / newSpacing
    new_wbct_size = [
        int(wbct_size[0] * wbct_spacing[0] / dynact_spacing[0]),
        int(wbct_size[1] * wbct_spacing[1] / dynact_spacing[1]),
        int(wbct_size[2] * wbct_spacing[2] / dynact_spacing[2]),
    ]

    resample_filter = sitk.ResampleImageFilter()
    resample_filter.SetSize(new_wbct_size)
    resample_filter.SetOutputOrigin(wbct_img.GetOrigin())
    resample_filter.SetOutputSpacing(dynact_spacing)
    resample_filter.SetOutputDirection(wbct_img.GetDirection())
    resample_filter.SetInterpolator(sitk.sitkLinear)
    resampled_img = resample_filter.Execute(wbct_img)

    return resampled_img


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Resample an image using SimpleITK")
    parser.add_argument("wbct_img_path", help="The WBCT image file path")
    parser.add_argument("dynact_img_path", help="The DYNACT image file path")
    args = parser.parse_args()

    wbct_img_path = args.wbct_img_path
    dynact_img_path = args.dynact_img_path

    resampled_path = os.path.splitext(wbct_img_path)[0]
    resampled_path = resampled_path + "_DOWNSAMPLED.nii"

    wbct_img = sitk.ReadImage(wbct_img_path)
    dynact_img = sitk.ReadImage(dynact_img_path)

    resampled_wbct = downsample(wbct_img, dynact_img)

    sitk.WriteImage(resampled_wbct, resampled_path)
