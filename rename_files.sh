#!/bin/bash

rm -r sidhochwind
rm -r images
mkdir images

instaloader --filename-pattern={date_utc} profile sidhochwind

cd sidhochwind 

# delete double image
rm "2021-02-06_16-59-45_2.jpg"
# replace the darling
mv "../killed-darlings/2014-05-06_15-13-35.jpg" "2013-12-25_12-54-41.jpg"

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