#! /bin/bash

#intended for use on the ARC cluster

#SBATCH --mail-user=fill.me.in@ucalgary.ca
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --time=01:30:00
#SBATCH --mem=64GB
#SBATCH --job-name=dynact2

module load matlab/r2020a
echo "Using MATLAB version: $(which matlab)"

echo Arguments:
INPUT_DIR=$1
SUBJECT=$2
echo INPUT_DIR: $INPUT_DIR
echo SUBJECT: $SUBJECT
echo 

MEXALL_DIR="Matlab Support Functions/DEA_RUN/DEA_2_0_SOURCE/SupportFiles/opcodemesh/src_matlab/"

# Navigate to the mexall.m directory, run mexall, and then return
echo "Navigating to $MEXALL_DIR and running mexall.m..."
pushd "$MEXALL_DIR" || { echo "Error: Could not navigate to $MEXALL_DIR. Exiting."; exit 1; }
matlab -batch "mexall" || { echo "Error: mexall.m failed. Exiting."; popd; exit 1; }
popd

echo "Running from directory $(pwd)"

echo matlab -batch "DEA('$INPUT_DIR', $SUBJECT)"

matlab -batch "DEA('$INPUT_DIR', $SUBJECT)"