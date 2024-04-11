#!/bin/bash -u
SEQ_REG_SCRIPT="A:\\Projects\\DYNACT2\\dynact2\\sequential_registration.py"

DYNACT_DIR="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_OPP\\RESAMPLED"
WBCT_MC1_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_WBCT\\DYNACT2_003_WBCT_CROP_PERI_MC1_BB_REORIENT_OPP_TRANSF.nii"
WBCT_TRP_MASK="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_WBCT\\DYNACT2_003_WBCT_CROP_PERI_TRP_BB_REORIENT_OPP_TRANSF.nii"
OUTPUT_DIR="D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_OPP\\REGISTRATION"

# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 1 -e 4"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 2 -e 5"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 3 -e 6"
# echo $cmd
# eval $cmd
cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 4 -e 7"
echo $cmd
eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 5 -e 8"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 6 -e 9"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 7 -e 10"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 8 -e 11"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 9 -e 12"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 10 -e 13"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 11 -e 14"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 12 -e 15"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 13 -e 16"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 14 -e 17"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 15 -e 18"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 16 -e 19"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 17 -e 20"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 18 -e 21"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 19 -e 22"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 20 -e 23"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 21 -e 24"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 22 -e 25"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 23 -e 26"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 24 -e 27"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 25 -e 28"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 26 -e 29"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 27 -e 30"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 28 -e 31"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 29 -e 32"
# echo $cmd
# eval $cmd
# cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\" -s 30 -e 33"
# echo $cmd
# eval $cmd