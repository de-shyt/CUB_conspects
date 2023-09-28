#!/bin/bash

cur_dir="$1"
cd "$cur_dir/pdf"
result_file="README.md"

echo -n "" > $result_file

for pdf_file in *; do
    pdf_name=$(basename "$pdf_file" )
    if [[ "$pdf_name" == *.pdf ]]; then
        last_modified=$(date -r "$pdf_name" "+%Y-%m-%d %H:%M:%S")
        pdf_name_encoded="$(echo "$pdf_name" | sed 's/ /%20/g')"
        echo "* [$pdf_name](./$pdf_name_encoded) [last update: $last_modified]" >> $result_file
    fi
done
