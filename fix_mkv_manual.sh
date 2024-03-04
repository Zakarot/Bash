#!/bin/bash
#Fix Metadata statistics for mkv files

Process-Folder() {
	#Takes single file/folder parameter and checks to see which if any child objects are folders and recursively calls the function on them.
	#This allows the main process to use this function to process an indeterminate number of subfolders looking for files to process.
	local folder="$1"
	cd "$folder"
	for item in *
	do
		if [ -d "$item" ]; then
			Process-Folder "$item"
		elif [[ "$item" =~ ".mkv" ]]; then
			Process-File "$item"
		fi
	done
	cd ../
}

Process-File() {
	#Processes files indentified in Function Process-Folder 
	local file="$1"
	echo "$file"
	mkvpropedit --add-track-statistics-tags "$file"
}

root=$(pwd)
if [ ! -d "$root" ]; then
	file="$root"
	Process-File "$file"
else
	Process-Folder "$root"
fi