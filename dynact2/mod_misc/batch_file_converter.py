import os
import shutil
import argparse

from file_converter import fileConverter

# Parse input arguments
parser = argparse.ArgumentParser()
parser.add_argument("inputDirectory", type=str, help="The input image directory")
args = parser.parse_args()

inputDir = args.inputDirectory

nifti_folder = os.path.join(inputDir, "nifti_volumes")
dicom_folder = os.path.join(inputDir, "dicom_volumes")

if not os.path.exists(nifti_folder):
    os.makedirs(nifti_folder)

if not os.path.exists(dicom_folder):
    os.makedirs(dicom_folder)

# Loop through all files in the directory
for f in os.listdir(inputDir):
    # Get the next item
    item = os.fsdecode(f)
    dicom_dir = os.path.join(inputDir, item)

    if os.path.isdir(dicom_dir):
        if "dicom_volumes" in dicom_dir:
            continue
        if "nifti_volumes" in dicom_dir:
            continue
        nifti = os.path.join(nifti_folder, item + ".nii")
        fileConverter(dicom_dir, nifti)

        shutil.move(dicom_dir, os.path.join(dicom_folder, item))
