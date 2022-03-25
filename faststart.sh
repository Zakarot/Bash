#!/bin/bash
#For files in subfolders of current directoty remux the files to be optimized for streaming if they are not already.

for folder in *
	do
	cd "$folder"
	for input in *
	do
		echo "$input"
		if [ $(mediainfo --Inform="General;%IsStreamable%" "$input") == "Yes" ]; then
			echo Streamable
		else
			echo Not Streamable
			mv "$input" "old.$input"
			qt-faststart "old.$input" "$input"
			rm "old.$input"
		fi
	done
	cd ../
done
