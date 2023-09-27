#!/bin/bash

cur_dir="$1"
pdf_dir="$cur_dir/pdf"

echo -n "" > "$pdf_dir/README.md"

for pdf_file in "$pdf_dir"/*.pdf; do
    pdf_name=$(basename "$pdf_file" .pdf)
    pdf_name_full="\"$pdf_name\".pdf"
    last_modified=$(date -r "$cur_dir/$pdf_name.md" "+%Y-%m-%d %H:%M:%S")
    echo "* [$pdf_name](./$pdf_name_full) [last update: $last_modified]" >> "$pdf_dir/README.md"
done
