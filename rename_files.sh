#!/bin/bash

# rm -r sidhochwind

# instaloader --filename-pattern={date_utc} profile sidhochwind

cd sidhochwind 

page=0
counter=0
declare -A file_map

# sort the files by name
for file in $(ls -1 *.*);
do
    # get the file name without extension
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"

    # check if the file has already been processed
    # assign a new counter value for this file
    if [ "$extension" = "jpg" ]; then
        new_name=$(printf "../images/%d_%d" $page $counter)
        ori_jpg_name=$(printf "%s.jpg" "$filename")
        jpg_name=$(printf "%s.jpg" "$new_name")
        ori_txt_name=$(printf "%s.txt" "$filename")
        txt_name=$(printf "%s.txt" "$new_name")

        # rename the files
        cp "$ori_jpg_name" "$jpg_name"
        cp "$ori_txt_name" "$txt_name"

        if [ $counter = 359 ]; then
            counter=0
            page=$((page+1))
        else 
            counter=$((counter+1))
        fi
    fi

done