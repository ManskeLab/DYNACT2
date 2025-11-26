#!/bin/bash -u
# example seq registration .sh script. Adjust subject numbers and output dir as needed
# Usage: batch_seq_reg.sh <path_to_images>
SEQ_REG_SCRIPT="dynact2/mod_registration/sequential_registration.py"
PATH_TO_IMAGES=$1

for SUBJECT in 001 002 003; do
  OUTPUT_DIR="${PATH_TO_IMAGES}DYNACT2_${SUBJECT}/DYNACT2_${SUBJECT}_ABAD/SEQ_REG"
  DYNACT_DIR="${PATH_TO_IMAGES}DYNACT2_${SUBJECT}/DYNACT2_${SUBJECT}_ABAD/RESAMPLED"
  WBCT_MC1_MASK="${PATH_TO_IMAGES}DYNACT2_${SUBJECT}/DYNACT2_${SUBJECT}_WBCT/DYNACT2_${SUBJECT}_WBCT_MC1_PERI_REORIENT_TRANSF.nii"
  WBCT_TRP_MASK="${PATH_TO_IMAGES}DYNACT2_${SUBJECT}/DYNACT2_${SUBJECT}_WBCT/DYNACT2_${SUBJECT}_WBCT_TRP_PERI_REORIENT_TRANSF_FIX.nii"

  # Reorient
  cmd="python \"${SEQ_REG_SCRIPT}\" \"${DYNACT_DIR}\" \"${WBCT_MC1_MASK}\" \"${WBCT_TRP_MASK}\" \"${OUTPUT_DIR}\""
  echo $cmd
  eval $cmd
done