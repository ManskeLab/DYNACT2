#!/bin/bash -u
FILE_CONVERTER_SCRIPT="/Users/mkuczyns/Projects/DYNACT2/dynact2/modMisc/file_converter.py"
DOWNSAMPLE_SCRIPT="/Users/mkuczyns/Projects/DYNACT2/dynact2/downsample.py"
REORIENT_SCRIPT="/Users/mkuczyns/Projects/DYNACT2/dynact2/reorient.py"

#--------------
# DYNACT2_200
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_WBCT_RECON_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_WBCT_RECON_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_WBCT_RECON_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_WBCT_RECON_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_WBCT_RECON_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_WBCT_RECON_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_200/DYNACT2_200_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_201
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_WBCT_RECON_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_WBCT_RECON_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_WBCT_RECON_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_WBCT_RECON_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_WBCT_RECON_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_201/DYNACT2_201_WBCT/DYNACT2_201_WBCT_RECON_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_201/DYNACT2_201_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_202
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_WBCT_RECON_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_WBCT_RECON_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_WBCT_RECON_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_WBCT_RECON_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_WBCT_RECON_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_202/DYNACT2_202_WBCT/DYNACT2_202_WBCT_RECON_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_202/DYNACT2_202_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_203
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_WBCT_RECON_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_WBCT_RECON_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_WBCT_RECON_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_WBCT_RECON_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_WBCT_RECON_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_203/DYNACT2_203_WBCT/DYNACT2_203_WBCT_RECON_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_203/DYNACT2_203_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_204
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_WBCT_RECON_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_WBCT_RECON_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_WBCT_RECON_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_WBCT_RECON_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_WBCT_RECON_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_WBCT/DYNACT2_204_WBCT_RECON_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_204/DYNACT2_204_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_205
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_WBCT_RECON_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_WBCT_RECON_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_WBCT_RECON_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_WBCT_RECON_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_WBCT_RECON_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_205/DYNACT2_205_WBCT/DYNACT2_205_WBCT_RECON_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_205/DYNACT2_205_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_207
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_WBCT_CROP_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_WBCT_CROP_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_WBCT_CROP_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_WBCT_CROP_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_WBCT_CROP_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_207/DYNACT2_207_WBCT/DYNACT2_207_WBCT_CROP_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_207/DYNACT2_207_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_208
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_WBCT_CROP_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_WBCT_CROP_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_WBCT_CROP_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_WBCT_CROP_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_WBCT_CROP_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_208/DYNACT2_208_WBCT/DYNACT2_208_WBCT_CROP_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_208/DYNACT2_208_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_209
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_WBCT_CROP_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_WBCT_CROP_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_WBCT_CROP_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_WBCT_CROP_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_WBCT_CROP_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_209/DYNACT2_209_WBCT/DYNACT2_209_WBCT_CROP_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_209/DYNACT2_209_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd

#--------------
# DYNACT2_210
#--------------
WBCT_MC1="/Volumes/LaCie/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_WBCT_CROP_MC1.nii"
WBCT_MC1_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_WBCT_CROP_MC1_DOWNSAMPLED.nii"
WBCT_MC1_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_WBCT_CROP_MC1_PERI.nii"

WBCT_TRP="/Volumes/LaCie/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_WBCT_CROP_TRP.nii"
WBCT_TRP_DOWNSAMPLE="/Volumes/LaCie/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_WBCT_CROP_TRP_DOWNSAMPLED.nii"
WBCT_TRP_SEG="/Volumes/LaCie/DYNACT2/models/DYNACT2_210/DYNACT2_210_WBCT/DYNACT2_210_WBCT_CROP_TRP_PERI.nii"

DYNACT_ABAD_VOL1="/Volumes/LaCie/DYNACT2/models/DYNACT2_210/DYNACT2_210_ABAD/RESAMPLED/VOLUME_1_RESAMPLED.nii"

# Downsample
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_MC1}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd
cmd="python \"${DOWNSAMPLE_SCRIPT}\" \"${WBCT_TRP}\" \"${DYNACT_ABAD_VOL1}\""
echo $cmd
eval $cmd

# Reorient
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_MC1_SEG}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_DOWNSAMPLE}\""
echo $cmd
eval $cmd
cmd="python \"${REORIENT_SCRIPT}\" \"${WBCT_TRP_SEG}\""
echo $cmd
eval $cmd