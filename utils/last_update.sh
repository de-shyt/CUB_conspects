#!/bin/bash

semester_dir="$1"
pdf_dir="$semester_dir/pdf"

echo -n "" > "$pdf_dir/README.md"

for pdf_file in "$pdf_dir"/*.pdf; do
    pdf_name=$(basename "$pdf_file")
    last_modified=$(date -r "$pdf_file" "+%Y-%m-%d %H:%M:%S")
    echo "* [$pdf_name](./$pdf_name) [last update: $last_modified]" >> "$pdf_dir/README.md"
done
