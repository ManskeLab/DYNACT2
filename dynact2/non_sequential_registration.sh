#! /bin/bash
#SBATCH --mail-user=christopher.brunet@ucalgary.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --time=48:00:00
#SBATCH --mem=64GB
#SBATCH --job-name=dynact2

echo Running non_sequential_registration.sh

echo start initialization

export PATH=~/software/miniconda3/bin:$PATH
source ~/software/init-conda
conda activate dynact2

echo Arguments:
INPUT_DIR=$1
MODEL=$2
echo INPUT_DIR: $INPUT_DIR
echo MODEL: $MODEL
echo 

SCRIPT_DIR=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
SCRIPT_DIR=($SCRIPT_DIR)
SCRIPT_DIR=$(dirname ${SCRIPT_DIR[0]})
echo $SCRIPT_DIR

# Compile slices
echo Compile slices in the directory $NPY_SUBDIR
echo python $SCRIPT_DIR/non_sequential_registration.py $INPUT_DIR -model $MODEL
python $SCRIPT_DIR/non_sequential_registration.py $INPUT_DIR -model $MODEL