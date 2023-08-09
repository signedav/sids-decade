#!/bin/bash

# rm -r sidhochwind

# instaloader --filename-pattern={date_utc} profile sidhochwind

cd images 

page=0
counter=0
declare -A file_map

# sort the files by date and time
for file in $(ls -1tr *.*)
do
    # get the file name without extension
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"

    # check if the file has already been processed
    if [[ ${file_map["$filename"]} ]]; then
        # use the existing counter value for this file
        new_name="${file_map["$filename"]}.$extension"
    else
        # assign a new counter value for this file
        new_name=$(printf "%d_%d.%s" $page $counter "$extension")
        file_map["$filename"]=$counter
        if [ $(($counter / ($page+1))) -gt 359 ]; then
            counter = 0
            page = $((page+1))
        else 
            counter=$((counter+1))
        fi
    fi

    # rename the file
    mv "$file" "$new_name"
done