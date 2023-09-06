#!/bin/bash

rm -r images
mkdir images

# rm -r sidhochwind
# instaloader --filename-pattern={date_utc} profile sidhochwind

cd sidhochwind 

# delete double image
mv "2021-02-06_16-59-45_2.jpg" "../killed-darlings/2021-02-06_16-59-45_2.jpg"
mv "2017-10-20_19-28-35_1.jpg" "../killed-darlings/2017-10-20_19-28-35_1.jpg"

# replace the ugly one with an old darling
cp "../killed-darlings/2014-05-06_15-13-35.jpg" "2013-12-25_12-54-41.jpg"

# no idea why we have sometimes too much or to less images but well no time now...
# 3rd year -2
mv "2015-10-08_12-26-30.jpg" "../killed-darlings/2015-10-08_12-26-30.jpg"
mv "2015-10-12_07-28-11.jpg" "../killed-darlings/2015-10-12_07-28-11.jpg"
# 4rd year +2
cp "../killed-darlings/2017-05-17_15-17-27.jpg" "2017-05-17_15-17-27.jpg"
cp "../killed-darlings/2017-05-28_12-52-26.jpg" "2017-05-28_12-52-26.jpg"
# 5th year -1
mv "2018-07-04_08-58-41.jpg" "../killed-darlings/2018-07-04_08-58-41.jpg"
# 6th year -1
mv "2018-12-28_10-55-00_2.jpg" "../killed-darlings/2018-12-28_10-55-00_2.jpg"
# 7th year -1
mv "2020-11-17_16-26-52.jpg" "../killed-darlings/2020-11-17_16-26-52.jpg"
# 8th year fine
# 9th year fine
# 10th remove profile pic
mv "2022-11-12_20-43-59_UTC_profile_pic.jpg" "../killed-darlings/2022-11-12_20-43-59_UTC_profile_pic.jpg"

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
        if [ -e "$ori_txt_name" ]; then
            cp "$ori_txt_name" "$txt_name"
        else
             touch "$txt_name"
        fi

        if [ $counter = 359 ]; then
            counter=0
            page=$((page+1))
        else 
            counter=$((counter+1))
        fi
    fi

done

# for some reason some images are not square...
# sudo apt-get -y install imagemagick

cd ..

# loop through each file in the directory
for file in images/*; do
  # check if file is an image
  if [[ ${file} =~ \.jpg$ ]]; then
    # get dimensions of the image
    dimensions=$(identify -format "%wx%h" ${file})
    # get the shorter side of the image
    # Split the string on "x" and save the values in an array
    IFS="x" read -r -a array <<< "${dimensions}"

    # Compare the two values and save the smaller one in a variable
    if [[ "${array[0]}" -lt "${array[1]}" ]]; then
    smaller="${array[0]}"
    else
    smaller="${array[1]}"
    fi
    # crop the image to a square
    convert ${file} -gravity center -crop ${smaller}x${smaller}+0+0 +repage ${file}
  fi
done