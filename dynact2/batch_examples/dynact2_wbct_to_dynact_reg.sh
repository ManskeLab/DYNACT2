#!/bin/bash -u
WBCT_TO_DYNACT_REG_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\wbct_to_dynact_registration.py"
TRANSFORM_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\transform.py"

#--------------
# DYNACT2_200
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT"
STUDY_ID_MC1="DYNACT2_200_MC1"
STUDY_ID_TRP="DYNACT2_200_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_201
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT"
STUDY_ID_MC1="DYNACT2_201_MC1"
STUDY_ID_TRP="DYNACT2_201_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_202
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT"
STUDY_ID_MC1="DYNACT2_202_MC1"
STUDY_ID_TRP="DYNACT2_202_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_203
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT"
STUDY_ID_MC1="DYNACT2_203_MC1"
STUDY_ID_TRP="DYNACT2_203_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_204
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT"
STUDY_ID_MC1="DYNACT2_204_MC1"
STUDY_ID_TRP="DYNACT2_204_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_205
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT"
STUDY_ID_MC1="DYNACT2_205_MC1"
STUDY_ID_TRP="DYNACT2_205_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_206
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT"
STUDY_ID_MC1="DYNACT2_206_MC1"
STUDY_ID_TRP="DYNACT2_206_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_207
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT"
STUDY_ID_MC1="DYNACT2_207_MC1"
STUDY_ID_TRP="DYNACT2_207_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_208
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT"
STUDY_ID_MC1="DYNACT2_208_MC1"
STUDY_ID_TRP="DYNACT2_208_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_209
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT"
STUDY_ID_MC1="DYNACT2_209_MC1"
STUDY_ID_TRP="DYNACT2_209_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_210
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT"
STUDY_ID_MC1="DYNACT2_210_MC1"
STUDY_ID_TRP="DYNACT2_210_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_211
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT"
STUDY_ID_MC1="DYNACT2_211_MC1"
STUDY_ID_TRP="DYNACT2_211_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_212
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT"
STUDY_ID_MC1="DYNACT2_212_MC1"
STUDY_ID_TRP="DYNACT2_212_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_213
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT"
STUDY_ID_MC1="DYNACT2_213_MC1"
STUDY_ID_TRP="DYNACT2_213_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_214
#--------------
DYNACT_ABAD_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_ABAD\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_OPP_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_OPP\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_KEY_VOL_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_KEY\\RESAMPLED\\Volume_1_Resampled.nii"
DYNACT_ABAD_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_TO_ABAD_MC1_INIT.txt"
DYNACT_OPP_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_TO_OPP_MC1_INIT.txt"
DYNACT_KEY_MC1_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_TO_KEY_MC1_INIT.txt"
DYNACT_ABAD_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_TO_ABAD_TRP_INIT.txt"
DYNACT_OPP_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_TO_OPP_TRP_INIT.txt"
DYNACT_KEY_TRP_INIT_TFM="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_TO_KEY_TRP_INIT.txt"
WBCT_MC1_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_MC1_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
WBCT_TRP_DOWNSAMPLED="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_TRP_BB_REORIENT_DOWNSAMPLED.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT"
STUDY_ID_MC1="DYNACT2_214_MC1"
STUDY_ID_TRP="DYNACT2_214_TRP"
FINAL_TFM_MC1_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_MC1_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_TRP_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_TRP_WBCT_TO_ABAD_REG.tfm"
FINAL_TFM_MC1_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_MC1_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_TRP_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_TRP_WBCT_TO_OPP_REG.tfm"
FINAL_TFM_MC1_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_MC1_WBCT_TO_KEY_REG.tfm"
FINAL_TFM_TRP_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_TRP_WBCT_TO_KEY_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_ABAD_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_ABAD_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_OPP_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_OPP_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_DOWNSAMPLED}\" \"${DYNACT_KEY_MC1_INIT_TFM}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_DYNACT_REG_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_DOWNSAMPLED}\" \"${DYNACT_KEY_TRP_INIT_TFM}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_ABAD}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_OPP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP_KEY}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_ABAD_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_ABAD}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_OPP_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_OPP}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1_KEY}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${DYNACT_KEY_VOL_1}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP_KEY}\" -i nn"
echo $cmd
eval $cmd
