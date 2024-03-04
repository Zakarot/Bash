#!/bin/bash
#Convert video files with E-AC-3 audio to standard AC-3

universalFfmpegFlags="-movflags +faststart -x265-params log-level=error -v 8 -stats"

Process-File() {
	#takes files indentified in Function Process-Folder, filters on included/excluded file types, and runs them through ffmpeg
	local file="$1"
	if [ $(mediainfo --Inform="Audio;%Format%" "$file") == "E-AC-3" ]; then
		ffmpeg -i "$file" -c:v copy -c:a ac3 -b:a 640k -c:s copy $universalFfmpegFlags "$file".mkv
		mkvpropedit --add-track-statistics-tags "$file".mkv
	fi
}

Process-Folder() {
	#Takes single file/folder parameter and checks to see which if any child objects are folders and recursively calls the function on them.
	#This allows the main process to use this function to process an indeterminate number of subfolders looking for files to process.
	local folder="$1"
	cd "$folder"
	for item in *
	do
		if [ -d "$item" ]; then
			Process-Folder "$item"
		else
			Process-File "$item"
		fi
	done
	cd ../
}

root=$(pwd)
if [ ! -d "$root" ]; then
	file="$root"
	Process-File "$file"
else
	Process-Folder "$root"
fi