#!/bin/bash

# SLURM properties 
#SBATCH --account=def-hoomandv
#SBATCH --gpus-per-node=1
#SBATCH --partition=agro-b
#SBATCH --cpus-per-task=24
#SBATCH --mem=200G
#SBATCH --time=1-12:00
#SBATCH --output=../resources/Logs/Slurm/%j.out


# Load modules 
module load CCEnv
module load StdEnv/2023
module load dorado/0.9.5



# Define variables 
## POD5 directory 
POD5_DIR="../resources/Data/pod5/"

## Output directory 
OUT_DIR="resources/Outputs/Dorado/"

## Barcode kits
BC_KIT="SQK-RBK114-96"

## Basecalling model (fast, hac, sup)
MODEL="hac"


# Run dorado 
dorado basecaller "${MODEL}" "${POD5_DIR}" --kit-name "${BC_KIT}"  > ../resources/Data/calls.bam

