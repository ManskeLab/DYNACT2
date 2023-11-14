#!/bin/bash -u
WBCT_TO_XCT_REG_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\wbct_to_xct_registration.py"
TRANSFORM_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\transform.py"

#--------------
# DYNACT2_200
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\DYNACT2_200_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\DYNACT2_200_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_200_MC1"
STUDY_ID_TRP="DYNACT2_200_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\DYNACT2_200_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\DYNACT2_200_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_201
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\DYNACT2_201_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\DYNACT2_201_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_201_MC1"
STUDY_ID_TRP="DYNACT2_201_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\DYNACT2_201_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\DYNACT2_201_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_202
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\DYNACT2_202_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\DYNACT2_202_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_202_MC1"
STUDY_ID_TRP="DYNACT2_202_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\DYNACT2_202_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\DYNACT2_202_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_203
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\DYNACT2_203_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\DYNACT2_203_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_203_MC1"
STUDY_ID_TRP="DYNACT2_203_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\DYNACT2_203_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\DYNACT2_203_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_204
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\DYNACT2_204_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\DYNACT2_204_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_204_MC1"
STUDY_ID_TRP="DYNACT2_204_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\DYNACT2_204_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\DYNACT2_204_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_205
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\DYNACT2_205_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\DYNACT2_205_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_205_MC1"
STUDY_ID_TRP="DYNACT2_205_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\DYNACT2_205_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\DYNACT2_205_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_206
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\DYNACT2_206_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\DYNACT2_206_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_206_MC1"
STUDY_ID_TRP="DYNACT2_206_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\DYNACT2_206_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\DYNACT2_206_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_207
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\DYNACT2_207_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\DYNACT2_207_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_207_MC1"
STUDY_ID_TRP="DYNACT2_207_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\DYNACT2_207_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\DYNACT2_207_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_208
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\DYNACT2_208_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\DYNACT2_208_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_208_MC1"
STUDY_ID_TRP="DYNACT2_208_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\DYNACT2_208_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\DYNACT2_208_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_209
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\DYNACT2_209_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\DYNACT2_209_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_209_MC1"
STUDY_ID_TRP="DYNACT2_209_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\DYNACT2_209_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\DYNACT2_209_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_210
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\DYNACT2_210_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\DYNACT2_210_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_210_MC1"
STUDY_ID_TRP="DYNACT2_210_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\DYNACT2_210_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\DYNACT2_210_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_211
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\DYNACT2_211_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\DYNACT2_211_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_211_MC1"
STUDY_ID_TRP="DYNACT2_211_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\DYNACT2_211_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\DYNACT2_211_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_212
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\DYNACT2_212_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\DYNACT2_212_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_212_MC1"
STUDY_ID_TRP="DYNACT2_212_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\DYNACT2_212_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\DYNACT2_212_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_213
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\DYNACT2_213_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\DYNACT2_213_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_213_MC1"
STUDY_ID_TRP="DYNACT2_213_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\DYNACT2_213_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\DYNACT2_213_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd

#--------------
# DYNACT2_214
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_MC1_BB_REORIENT.nii"
INIT_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\DYNACT2_214_WBCT_TO_XCT_MC1_INIT.txt"
XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_TRP_BB_REORIENT.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_TRP_BB_REORIENT.nii"
INIT_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\DYNACT2_214_WBCT_TO_XCT_TRP_INIT.txt"
OUTPUT_PATH="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output"
STUDY_ID_MC1="DYNACT2_214_MC1"
STUDY_ID_TRP="DYNACT2_214_TRP"
FINAL_TFM_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\DYNACT2_214_MC1_WBCT_TO_XCT_REG.tfm"
FINAL_TFM_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\DYNACT2_214_TRP_WBCT_TO_XCT_REG.tfm"

# Registrations
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${INIT_TFM_MC1}\" \"${STUDY_ID_MC1}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd
cmd="python \"${WBCT_TO_XCT_REG_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${INIT_TFM_TRP}\" \"${STUDY_ID_TRP}\" \"${OUTPUT_PATH}\""
echo $cmd
eval $cmd

# Transformations
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1}\" \"${FINAL_TFM_MC1}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP}\" \"${FINAL_TFM_TRP}\" -i linear"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_MC1}\" \"${WBCT_MC1_PERI}\" \"${FINAL_TFM_MC1}\" -i nn"
echo $cmd
eval $cmd
cmd="python \"${TRANSFORM_SCRIPT}\" \"${XCT_TRP}\" \"${WBCT_TRP_PERI}\" \"${FINAL_TFM_TRP}\" -i nn"
echo $cmd
eval $cmd
