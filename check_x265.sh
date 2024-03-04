#!/bin/bash
#Check x265 HDR codec information

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
	if [ $(mediainfo --Inform="Video;%Format%" "$file") == "HEVC" ]; then
		echo "$file"
		echo "Video Format: " $(mediainfo --Inform="Video;%Format%" "$file")
		echo "Color Space: " $(mediainfo --Inform="Video;%ColorSpace%" "$file")
		echo "Chroma subsampling: " $(mediainfo --Inform="Video;%ChromaSubsampling%" "$file")
		echo "Bit Depth: " $(mediainfo --Inform="Video;%BitDepth%" "$file")
	fi

}

root=$(pwd)
if [ ! -d "$root" ]; then
	file="$root"
	Process-File "$file"
else
	Process-Folder "$root"
fi