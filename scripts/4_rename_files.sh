#!/bin/bash

# Directories
INPUT_DIR="fastq"
OUTPUT_DIR="fastq_renamed"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Loop over files
for f in "$INPUT_DIR"/barcode*.fastq.gz; do
    filename=$(basename "$f")
    num=$(echo "$filename" | sed -E 's/[^0-9]*0*([0-9]+)\.fastq\.gz/\1/')
    formatted_num=$(printf "%02d" "$num")
    new_filename="ADR1-${formatted_num}.fastq.gz"

    # Copy safely without overwriting
    cp -n "$f" "$OUTPUT_DIR/$new_filename"
done

echo "Renaming completed without overwriting originals."

