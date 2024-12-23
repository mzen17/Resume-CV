#!/bin/bash

# Usage: ./anonymize.sh <input_file>

INPUT_FILE=$1
OUTPUT_FILE="tmp"

if [ -z "$INPUT_FILE" ]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: File $INPUT_FILE does not exist."
  exit 1
fi

# List of replacements (old value, new value)
declare -A REPLACEMENTS=(
  ["Mike Zeng"]="Human Being"
  ["Iowa City, IA"]="USA"
  ["Iowa"]="state"
  ["University of Iowa"]="T100 University"
  ["Technology Student Association Tests of Engineering, Aptitude, and Math (TEAMS)"]="National Technology Contest"
  ["www.linkedin.com/in/mike-zeng-189756257"]="linkedin.com"
  ["mzen.dev"]="website.com"
  ["UI Hydroinformatics Laboratory"]="T100 University Lab"
  ["Advancing Towards Human Recreation"]="Self-Founded Research"
  ["mzeng1417@gmail.com"]="example@example.com"
  ["Rishab Nithyanand CS:5990"]="Human Being, University Credit"
  ["Omer Mermer"]="Human Being"
  ["(408) 430-7654"]="(111) 111-1111"
)

# Read the file content
CONTENT=$(< "$INPUT_FILE")

# Perform replacements
for OLD in "${!REPLACEMENTS[@]}"; do
  NEW=${REPLACEMENTS[$OLD]}
  CONTENT=${CONTENT//"$OLD"/"$NEW"}
done

# Write the updated content to the output file
echo "$CONTENT" > "$OUTPUT_FILE"

echo "Anonymized content written to $OUTPUT_FILE"
