#!/bin/bash

# SLURM properties 
#SBATCH --account=def-hoomandv
#SBATCH --partition=skylake
#SBATCH --cpus-per-task=40
#SBATCH --mem=50G
#SBATCH --time=3:00:00
#SBATCH --output=../resources/Logs/Slurm/%j.out



# Directory containing the FASTQ files
FASTQ_DIR="../results/fastq/"

# Move into the directory
cd "$FASTQ_DIR" || { echo "Directory $FASTQ_DIR not found!"; exit 1; }

# Loop through each FASTQ file
for file in *.fastq; do
    # Extract the barcode number (e.g., barcode01, barcode02, etc.)
    barcode=$(echo "$file" | grep -o "barcode[0-9]\+")

    # Define the new simpler name
    new_name="${barcode}.fastq"

    # Rename the file
    mv "$file" "$new_name"

    # Compress the file
    gzip "$new_name"
done

echo "Renaming and compression complete!"

