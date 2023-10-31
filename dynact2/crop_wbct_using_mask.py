"""
crop_wbct_using_mask.py

Created by:   Michael Kuczynski
Created on:   2023.10.24

Description: 
"""

import os
import argparse
import SimpleITK as sitk


def crop_wbct_using_mask(wbct_img, seg_img):
    """

    Parameters
    ----------

    Returns
    -------
    """
    dilate = sitk.BinaryDilateImageFilter()
    dilate.SetKernelRadius([5,5,5])
    dilate.SetForegroundValue(1)
    dilated_img = dilate.Execute(seg_img)

    masked_img = sitk.Mask(wbct_img, dilated_img)

    return masked_img


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Resample an image using SimpleITK")
    parser.add_argument("wbct_img_path", help="The WBCT image file path")
    parser.add_argument("mc1_seg", help="The MC1 mask")
    parser.add_argument("trp_seg", help="The TRP mask")
    args = parser.parse_args()

    wbct_img_path = args.wbct_img_path
    mc1_seg_path = args.mc1_seg
    trp_seg_path = args.trp_seg

    wbct_img = sitk.ReadImage(wbct_img_path)
    mc1_seg_img = sitk.ReadImage(mc1_seg_path)
    trp_seg_img = sitk.ReadImage(trp_seg_path)

    cropped_mc1 = crop_wbct_using_mask(wbct_img, mc1_seg_img)
    cropped_trp = crop_wbct_using_mask(wbct_img, trp_seg_img)

    output_mc1_path = os.path.splitext(wbct_img_path)[0]
    output_mc1_path = output_mc1_path + "_MC1.nii"

    output_trp_path = os.path.splitext(wbct_img_path)[0]
    output_trp_path = output_trp_path + "_TRP.nii"

    sitk.WriteImage(cropped_mc1, output_mc1_path)
    sitk.WriteImage(cropped_trp, output_trp_path)
