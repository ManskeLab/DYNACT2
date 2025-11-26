#!/bin/bash -u
AUTOCONTOUR_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\autocontour.py"
COMBINE_MASK_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\combine_masks.py"

#--------------
# DYNACT2_200
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_201
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_202
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_203
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_204
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_205
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_206
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_207
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_208
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_209
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_210
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_211
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_212
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_213
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_214
#--------------
IMAGE_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
IMAGE_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"

IMAGE_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK.nii"
IMAGE_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK.nii"

cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${AUTOCONTOUR_SCRIPT}\" \"${IMAGE_TRP}\""
echo $cmd
eval $cmd

cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_MC1_MASK}\""
echo $cmd
eval $cmd
cmd="python \"${COMBINE_MASK_SCRIPT}\" \"${IMAGE_TRP_MASK}\""
echo $cmd
eval $cmd
