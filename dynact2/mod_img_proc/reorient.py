"""
reorient.py

Created by:   Michael Kuczynski
Created on:   2023.01.10

Description: Reorients WBCT images to match the orientation of the DYNACT image. 
"""

import os
import argparse
import SimpleITK as sitk


def reorient(wbct_img):
    """
    By default, images from the WBCT scanner are in the LPI orientation, while
    the DYNACT images are in the LAS orientation. Note these are NOT DICOM
    orientations, but NIFTI image orientations (there is a difference). To help
    obtain better registration results, reorient the WBCT image to match the
    DYNACT images.

    Parameters
    ----------
    wbct_img : SimpleITK.Image
        Input WBCT image to be reoriented to LAS

    Returns
    -------
    wbct_img : SimpleITK.Image
        Reoriented WBCT image
    """
    # Set the orientation to LAS
    wbct_img.SetDirection([-1, 0, 0, 0, 1, 0, 0, 0, -1])

    return wbct_img

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Resample an image using SimpleITK")
    parser.add_argument("wbct_img_path", help="The WBCT image file path")
    args = parser.parse_args()

    wbct_img_path = args.wbct_img_path

    reorient_path = os.path.splitext(wbct_img_path)[0]
    reorient_path = reorient_path + "_REORIENT.nii"

    wbct_img = sitk.ReadImage(wbct_img_path)

    reorient_wbct = reorient(wbct_img)

    sitk.WriteImage(reorient_wbct, reorient_path)
