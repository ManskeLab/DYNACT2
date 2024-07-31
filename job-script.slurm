#!/bin/bash
####### Reserve computing resources #############

#SBATCH --mail-user=christopher.brunet@ucalgary.ca
#SBATCH --mail-type=ALL
#SBATCH -o output.out 
#SBATCH -e errors.err

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --mem=1G
#SBATCH --partition=cpu2019

####### Load software ###########################
module load python
module load anaconda3

####### Run your script #########################
python non_sequential_registration.py '/media/kratos/Manskelab/ManskelabProjects/DYNACT2/models'