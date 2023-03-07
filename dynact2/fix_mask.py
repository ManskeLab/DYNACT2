"""
fix_mask.py

Created by:   Michael Kuczynski
Created on:   2023.03.06

Description: Fixes masks generated from the FemurSegmentation module. Some masks
                contain two values (i.e., 1 and 2) instead of one value.
"""

import os
import argparse
import SimpleITK as sitk


def fix_mask(wbct_mask):
    """
    Fixes an input WBCT mask to contain a single value.

    Parameters
    ----------
    wbct_mask : SimpleITK.Image
        Input WBCT mask to be fixed

    Returns
    -------
    mask_fix : SimpleITK.Image
        Fixed WBCT mask
    """
    mask_fix = sitk.BinaryThreshold(wbct_mask, 1, 100, 1, 0)
    return mask_fix


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("wbct_mask_path", help="The WBCT mask file path")
    args = parser.parse_args()

    wbct_mask_path = args.wbct_mask_path

    fixed_mask_path = os.path.splitext(wbct_mask_path)[0]
    fixed_mask_path = fixed_mask_path + "_FIX.nii"

    wbct_mask = sitk.ReadImage(wbct_mask_path, sitk.sitkUInt8)

    fixed_mask = fix_mask(wbct_mask)

    sitk.WriteImage(fixed_mask, fixed_mask_path)
