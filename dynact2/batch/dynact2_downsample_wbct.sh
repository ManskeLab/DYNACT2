#!/bin/bash -u
CROP_WBCT_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\crop_wbct_using_mask.py"
BOUNDING_BOX_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\bounding_box.py"
REORIENT_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\reorient.py"
DOWNSAMPLE_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\downsample.py"

#--------------
# DYNACT2_200
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_WBCT\\DYNACT2_200_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_200\\DYNACT2_200_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_201
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_WBCT\\DYNACT2_201_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_201\\DYNACT2_201_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_202
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_WBCT\\DYNACT2_202_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_202\\DYNACT2_202_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_203
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_WBCT\\DYNACT2_203_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_203\\DYNACT2_203_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_204
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_WBCT\\DYNACT2_204_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_204\\DYNACT2_204_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_205
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_WBCT\\DYNACT2_205_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_205\\DYNACT2_205_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_206
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_WBCT\\DYNACT2_206_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_206\\DYNACT2_206_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_207
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_WBCT\\DYNACT2_207_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_207\\DYNACT2_207_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_208
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_WBCT\\DYNACT2_208_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_208\\DYNACT2_208_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_209
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_WBCT\\DYNACT2_209_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_209\\DYNACT2_209_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_210
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_WBCT\\DYNACT2_210_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_210\\DYNACT2_210_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_211
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_WBCT\\DYNACT2_211_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_211\\DYNACT2_211_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_212
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_WBCT\\DYNACT2_212_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_212\\DYNACT2_212_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_213
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_WBCT\\DYNACT2_213_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_213\\DYNACT2_213_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_214
#--------------
WBCT="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP.nii"
WBCT_MC1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_MC1.nii"
WBCT_MC1_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_MC1.nii"
WBCT_MC1_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_MC1_BB.nii"
WBCT_MC1_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_MC1_BB.nii"
WBCT_MC1_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_MC1_BB_REORIENT.nii"
WBCT_TRP="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_TRP.nii"
WBCT_TRP_PERI="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_TRP.nii"
WBCT_TRP_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_TRP_BB.nii"
WBCT_TRP_PERI_BB="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_PERI_TRP_BB.nii"
WBCT_TRP_BB_RO="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_WBCT\\DYNACT2_214_WBCT_CROP_TRP_BB_REORIENT.nii"
DYNACT_FRAME_1="D:\\OneDrive - University of Calgary\\ManskeLabImages\\DYNACT\\06 - DYNACT2\\models\\DYNACT2_214\\DYNACT2_214_ABAD\\BONE PLUS\\nifti_volumes\\Volume_1.nii"

cmd="python \"${CROP_WBCT_SCRIPT}\" \"${WBCT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_MC1_PERI}\" \"${WBCT_MC1_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${BOUNDING_BOX_SCRIPT}\" \"${WBCT_TRP_PERI}\" \"${WBCT_TRP_PERI}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_BB}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_PERI_BB}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP_BB_RO}\" \"${DYNACT_FRAME_1}\""
echo $cmd
eval $cmd
