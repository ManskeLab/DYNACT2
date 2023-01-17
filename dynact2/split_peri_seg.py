"""
split_peri_seg.py

Created by:   Michael Kuczynski
Created on:   2023.01.10

Description: Split  
"""

import os
import argparse
import SimpleITK as sitk


def split_segmentation(peri_seg):
    """
    Splits a segmentation image of the TMC joint into a MC1 and TRP mask.

    Parameters
    ----------
    peri_seg : SimpleITK.Image

    Returns
    -------
    mc1_seg : SimpleITK.Image

    trp_seg : SimpleITK.Image
    """
    img_conn = sitk.ConnectedComponent(peri_seg, peri_seg, True)
    img_conn = sitk.RelabelComponent(img_conn, sortByObjectSize=True)
    mc1_seg = 1 * (img_conn == 1)
    trp_seg = 1 * (img_conn == 2)

    return mc1_seg, trp_seg


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Resample an image using SimpleITK")
    parser.add_argument("seg", help="The segmentation image file")
    args = parser.parse_args()

    seg = args.seg

    seg_path = os.path.splitext(seg)[0]
    mc1_seg_path = seg_path + "_MC1_PERI.nii"
    trp_seg_path = seg_path + "_TRP_PERI.nii"

    seg_img = sitk.ReadImage(seg, sitk.sitkUInt8)

    mc1_seg_img, trp_seg_img = split_segmentation(seg_img)

    sitk.WriteImage(mc1_seg_img, mc1_seg_path)
    sitk.WriteImage(trp_seg_img, trp_seg_path)
