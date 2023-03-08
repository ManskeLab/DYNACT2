#!/bin/bash -u
MOTION_SCRIPT="/Users/mkuczyns/Projects/DYNACT2/dynact2/compute_motion.py"

#--------------
# DYNACT2_001
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_001/DYNACT2_001_WBCT/DYNACT2_001_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_001/DYNACT2_001_WBCT/DYNACT2_001_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_001/DYNACT2_001_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_001_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_001_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_002
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_002/DYNACT2_002_WBCT/DYNACT2_002_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_002/DYNACT2_002_WBCT/DYNACT2_002_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_002/DYNACT2_002_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_002_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_002_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_003
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_003/DYNACT2_003_WBCT/DYNACT2_003_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_003/DYNACT2_003_WBCT/DYNACT2_003_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_003/DYNACT2_003_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_003_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_003_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_004
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_004/DYNACT2_004_WBCT/DYNACT2_004_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_004/DYNACT2_004_WBCT/DYNACT2_004_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_004/DYNACT2_004_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_004_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_004_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_005
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_005/DYNACT2_005_WBCT/DYNACT2_005_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_005/DYNACT2_005_WBCT/DYNACT2_005_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_005/DYNACT2_005_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_005_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_005_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_006
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_006/DYNACT2_006_WBCT/DYNACT2_006_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_006/DYNACT2_006_WBCT/DYNACT2_006_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_006/DYNACT2_006_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_006_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_006_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_007
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_007/DYNACT2_007_WBCT/DYNACT2_007_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_007/DYNACT2_007_WBCT/DYNACT2_007_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_007/DYNACT2_007_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_007_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_007_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_008
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_008/DYNACT2_008_WBCT/DYNACT2_008_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_008/DYNACT2_008_WBCT/DYNACT2_008_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_008/DYNACT2_008_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_008_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_008_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_009
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_009/DYNACT2_009_WBCT/DYNACT2_009_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_009/DYNACT2_009_WBCT/DYNACT2_009_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_009/DYNACT2_009_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_009_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_009_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_200
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_200/DYNACT2_200_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_200_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_200_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_201
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_201/DYNACT2_201_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_201_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_201_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_202
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_202/DYNACT2_202_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_202_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_202_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_203
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_203/DYNACT2_203_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_203_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_203_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_204
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_204/DYNACT2_204_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_204_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_204_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_205
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_205/DYNACT2_205_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_205_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_205_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_206
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_206/DYNACT2_206_WBCT/DYNACT2_206_WBCT_TO_DYNACT_MC1_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_206/DYNACT2_206_WBCT/DYNACT2_206_WBCT_TO_DYNACT_TRP_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_206/DYNACT2_206_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_206_PERI_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_206_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_207
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_207/DYNACT2_207_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_207_PLED_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_207_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_208
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_208/DYNACT2_208_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_208_PLED_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_208_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_209
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_209/DYNACT2_209_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_209_PLED_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_209_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_210
#--------------
WBCT_TO_DYNACT_MC1_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_MC1_WBCT_TO_DYNACT_REG.tfm"
WBCT_TO_DYNACT_TRP_TFM="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_TRP_WBCT_TO_DYNACT_REG.tfm"
DYNACT_TFMS="/Volumes/Manskelab/ManskelabProjects/DYNACT2/models/DYNACT2_210/DYNACT2_210_ABAD/SEQ_REG/FinalTFMs"
WBCT_MC1_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_210_PLED_REORIEN_MC1_SCS.txt"
WBCT_TRP_POINTS="/Users/mkuczyns/Projects/DYNACT2/dynact2/output/DYNACT2_210_REORIENT_TR_TRP_SCS.txt"
OUTPUT_DIR="/Users/mkuczyns/Projects/DYNACT2/dynact2/output"

cmd="python \"${MOTION_SCRIPT}\" \"${WBCT_TO_DYNACT_MC1_TFM}\" \"${WBCT_TO_DYNACT_TRP_TFM}\" \"${DYNACT_TFMS}\" \"${WBCT_MC1_POINTS}\" \"${WBCT_TRP_POINTS}\" \"${OUTPUT_DIR}\""
echo $cmd
eval $cmd
