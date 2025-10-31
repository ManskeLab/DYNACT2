#! /bin/bash

# intended for use on the ARC cluster

#SBATCH --mail-user=fill_me_in@ucalgary.ca
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --time=01:30:00
#SBATCH --mem=64GB
#SBATCH --job-name=dynact2

echo Running analyze_results.sh

echo start initialization

export PATH=~/software/miniconda3/bin:$PATH
source ~/software/init-conda
conda activate dynact2

echo Arguments:
INPUT_DIR=$1
SUBJECT=$2
echo INPUT_DIR: $INPUT_DIR
echo SUBJECT: $SUBJECT
echo 

SCRIPT_DIR=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
SCRIPT_DIR=($SCRIPT_DIR)
SCRIPT_DIR=$(dirname ${SCRIPT_DIR[0]})
echo $SCRIPT_DIR

# Compile slices
echo Compile slices in the directory $NPY_SUBDIR
echo python $SCRIPT_DIR/analyze_results.py $INPUT_DIR $SUBJECT
python $SCRIPT_DIR/analyze_results.py $INPUT_DIR $SUBJECT