#!/bin/bash

# Define directories
LIB1_DIR="Lib1"
LIB2_DIR="Lib2"
OUTPUT_DIR="fastq"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through all samples in Lib1
for file1 in "$LIB1_DIR"/*.fastq.gz; do
    # Extract sample name
    sample=$(basename "$file1" .fastq.gz)

    # Corresponding file in Lib2
    file2="$LIB2_DIR/${sample}.fastq.gz"

    # Output merged file
    output="$OUTPUT_DIR/${sample}.fastq.gz"

    # Check if file exists in Lib2
    if [[ -f "$file2" ]]; then
        # Merge the two files
        cat "$file1" "$file2" > "$output"
        echo "Merged $sample"
    else
        # If no matching file in Lib2, just copy from Lib1
        cp "$file1" "$output"
        echo "Copied only from Lib1: $sample (no file in Lib2)"
    fi
done

# Now check if there are samples only in Lib2 but missing in Lib1
for file2 in "$LIB2_DIR"/*.fastq.gz; do
    sample=$(basename "$file2" .fastq.gz)
    output="$OUTPUT_DIR/${sample}.fastq.gz"
    if [[ ! -f "$OUTPUT_DIR/$sample.fastq.gz" ]]; then
        cp "$file2" "$output"
        echo "Copied only from Lib2: $sample (no file in Lib1)"
    fi
done

echo "Merging complete!"

