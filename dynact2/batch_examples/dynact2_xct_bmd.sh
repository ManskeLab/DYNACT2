#!/bin/bash -u
BMD_MASK_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\bmd_masked.py"

#--------------
# DYNACT2_200
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_201
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_202
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_203
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_204
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_205
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_206
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_207
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_208
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_209
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_210
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_211
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_212
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_213
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd


#--------------
# DYNACT2_214
#--------------
XCT_MC1="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1.nii"
XCT_MC1_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q1.nii"
XCT_MC1_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q2.nii"
XCT_MC1_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q3.nii"
XCT_MC1_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_MC1_MASK_Q4.nii"

XCT_TRP="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP.nii"
XCT_TRP_Q1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q1.nii"
XCT_TRP_Q2_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q2.nii"
XCT_TRP_Q3_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q3.nii"
XCT_TRP_Q4_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_HRpQCT\\stack_reg_output\\FULL_IMAGE_TRP_MASK_Q4.nii"

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_MC1}\" \"${XCT_MC1_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd

cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q1_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q2_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q3_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
cmd="python \"${BMD_MASK_SCRIPT}\" \"${XCT_TRP}\" \"${XCT_TRP_Q4_MASK}\" HU 8192 0.23960 1613.94397 -392.247009"
echo $cmd
eval $cmd
