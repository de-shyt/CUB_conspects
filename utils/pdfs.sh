#!/bin/bash

# Path to the directory which is a "root" for MD files and their pdfs (i.e. "3-spring2024")
cur_dir="$1"
cd "$cur_dir/pdf"
result_file="README.md"

echo -n "" > $result_file

for pdf_file in *; do
    pdf_name=$(basename "$pdf_file" )
    if [[ "$pdf_name" == *.pdf ]]; then
        pdf_name_encoded="$(echo "$pdf_name" | sed 's/ /%20/g')"
        echo "* [$pdf_name](./$pdf_name_encoded)" >> $result_file
    fi
done
