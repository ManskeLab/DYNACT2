"""
bounding_box.py

Created by:   Michael Kuczynski
Created on:   2023.01.10

Description: Crops a mask using the bounding box.
"""

import os
import argparse
import numpy as np
import SimpleITK as sitk


def bounding_box(mask):
    """
    Computes the bounding box of the input mask and crops the mask using the
    size and starting location of the bounding box.

    Parameters
    ----------
    mask : SimpleITK.Image

    Returns
    -------
    bounding_box_image : SimpleITK.Image
    """
    # Run connected components
    connected_comp = sitk.ConnectedComponentImageFilter()
    connected_comp_img = connected_comp.Execute(mask)

    # Relabel and sort by object size
    relabel = sitk.RelabelComponentImageFilter()
    relabel.SortByObjectSizeOn()
    relabel_img = relabel.Execute(connected_comp_img)

    thresh = sitk.BinaryThresholdImageFilter()
    thresh.SetLowerThreshold(1)
    thresh.SetUpperThreshold(1)
    thresh.SetOutsideValue(0)
    thresh.SetInsideValue(1)
    thresh_img = thresh.Execute(relabel_img)

    stats_filter = sitk.LabelShapeStatisticsImageFilter()
    stats_filter.Execute(thresh_img)
  
    # Get the bounding box. Returns an array in the format:
    # [x_start, y_start, z_start, x_size, y_size, z_size]
    bounding_box_dim = np.array(stats_filter.GetBoundingBox(1))
    x_start = bounding_box_dim[0]
    y_start = bounding_box_dim[1]
    z_start = bounding_box_dim[2]
    x_end = x_start + bounding_box_dim[3]
    y_end = y_start + bounding_box_dim[4]
    z_end = z_start + bounding_box_dim[5]

    # Crop the image with the bounding box
    bounding_box_image = thresh_img[x_start:x_end, y_start:y_end, z_start:z_end]

    return bounding_box_image 


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Crop a mask using SimpleITK")
    parser.add_argument("mask_path", help="The mask image file path")
    args = parser.parse_args()

    mask_path = args.mask_path

    boundingbox_path = os.path.splitext(mask_path)[0]
    boundingbox_path = boundingbox_path + "_BOUNDINGBOX.nii"

    mask = sitk.ReadImage(mask_path)

    boundingbox_img = bounding_box(mask)

    sitk.WriteImage(boundingbox_img, boundingbox_path)
