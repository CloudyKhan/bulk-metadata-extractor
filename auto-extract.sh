#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 [-d directory] [-o out_f] [-w]"
    echo " -d  Specify the directory containing files (default: current directory)"
    echo " -o  Specify the output file name for metadata (optional)"
    echo " -w  Generate a creator wordlist from metadata (optional)"
    exit 1
}

# Default directory, output file, and wordlist generation
directory="."
out_f=""
generate_wordlist=false

# Parse options
while getopts ":d:o:w" opt; do
    case $opt in
        d) directory="$OPTARG" ;;
        o) out_f="$OPTARG" ;;
        w) generate_wordlist=true ;;
        *) usage ;;
    esac
done

# Check if directory exists
if [[ ! -d "$directory" ]]; then
    echo "Directory $directory does not exist."
    exit 1
fi

# Prepare output if specified
if [[ -n "$out_f" ]]; then
    # Clear or create output file
    > "$out_f"
fi

# Loop through each file in the specified directory
for file in "$directory"/*; do
    echo "Extracting metadata for: $file"
    if [[ -n "$out_f" ]]; then
        # Write to output file if specified
        echo "File: $file" >> "$out_f"
        exiftool "$file" >> "$out_f"
        echo "----------------------------------------" >> "$out_f"
    else
        # Print to terminal if no output file specified
        echo "File: $file"
        exiftool "$file"
        echo "----------------------------------------"
    fi
done

# Inform the user of the completion status
if [[ -n "$out_f" ]]; then
    echo "Metadata extraction complete. Results saved in $out_f"
else
    echo "Metadata extraction complete."
fi

# Generate creator wordlist if requested
if $generate_wordlist && [[ -n "$out_f" ]]; then
    awk -F': ' '/Creator|Author/ {print $2}' "$out_f" | sort | uniq > creator_wordlist.txt
    echo "Creator wordlist generated in creator_wordlist.txt"
elif $generate_wordlist && [[ -z "$out_f" ]]; then
    echo "Wordlist generation requires an output file (-o)."
fi
