#!/bin/bash -u
SEQ_REG_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\sequential_registration.py"

# #--------------
# # DYNACT2_200
# #--------------
# DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_ABAD\\RESAMPLED"
# DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_KEY\\RESAMPLED"
# DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_OPP\\RESAMPLED"
# WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
# WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
# WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
# WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
# WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
# WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
# OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_ABAD\\REGISTRATION"
# OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_KEY\\REGISTRATION"
# OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_OPP\\REGISTRATION"

# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
# echo $cmd
# eval $cmd

#--------------
# DYNACT2_201
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_202
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_203
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_204
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_205
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_206
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_207
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_208
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_209
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_210
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_211
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_212
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_213
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_214
#--------------
DYNACT_ABAD_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_ABAD\\RESAMPLED"
DYNACT_KEY_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_KEY\\RESAMPLED"
DYNACT_OPP_DIR="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_OPP\\RESAMPLED"
WBCT_MC1_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_MC1_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_MC1_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_MC1_BB_REORIENT_KEY_TRANSF.nii"
WBCT_MC1_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_SEG_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_TRP_BB_REORIENT_ABAD_TRANSF.nii"
WBCT_TRP_SEG_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_TRP_BB_REORIENT_KEY_TRANSF.nii"
WBCT_TRP_SEG_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR_ABAD="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_ABAD\\REGISTRATION"
OUTPUT_DIR_KEY="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_KEY\\REGISTRATION"
OUTPUT_DIR_OPP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_OPP\\REGISTRATION"

cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_ABAD_DIR}\" \"${WBCT_MC1_SEG_ABAD}\" \"${WBCT_TRP_SEG_ABAD}\" \"${OUTPUT_DIR_ABAD}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_KEY_DIR}\" \"${WBCT_MC1_SEG_KEY}\" \"${WBCT_TRP_SEG_KEY}\" \"${OUTPUT_DIR_KEY}\""
echo $cmd
eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_OPP_DIR}\" \"${WBCT_MC1_SEG_OPP}\" \"${WBCT_TRP_SEG_OPP}\" \"${OUTPUT_DIR_OPP}\""
echo $cmd
eval $cmd