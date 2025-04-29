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

# Define Variables 
BAM_FILE="../resources/Data/calls.bam"
OUT_DIR="../results/fastq"

# Create directory 
# mkdir -p "$OUT_DIR"

# Run dorado 
dorado demux --output-dir "${OUT_DIR}"\
    --no-classify "${BAM_FILE}" \
    --emit-fastq

