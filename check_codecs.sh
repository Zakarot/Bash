#!/bin/bash
#Check mkv files for audio format and number of channels.

Process-Folder() {
	#Takes single file/folder parameter and checks to see which if any child objects are folders and recursively calls the function on them.
	#This allows the main process to use this function to process an indeterminate number of subfolders looking for files to process.
	local folder="$1"
	cd "$folder"
	for item in *
	do
		if [ -d "$item" ]; then
			Process-Folder "$item"
		elif [[ "$item" =~ ".mkv" || "$item" =~ ".mp4" ]]; then
			Process-File "$item"
		fi
	done
	cd ../
}

Process-File() {
	#Processes files indentified in Function Process-Folder 
	local file="$1"
    echo "$file"
    echo "Video Format: $(mediainfo --Inform="Video;%Format%" "$file")"
    echo "Video Bitrate: $(mediainfo --Inform="Video;%BitRate/String%" "$file")"
    echo "Video Pixels: $(mediainfo --Inform="Video;%Height%" "$file")x$(mediainfo --Inform="Video;%Width%" "$file")"
    echo "Color Primaries: $(mediainfo --Inform="Video;%colour_primaries%" "$file")"
    echo "Streamable: $(mediainfo --Inform="General;%IsStreamable%" "$file")"
    echo "Audio Format: $(mediainfo --Inform="Audio;%Format%" "$file")"
    echo "Audio Language: $(mediainfo --Inform="Audio;%Language%" "$file")"
    echo "Audio Channels: $(mediainfo --Inform="Audio;%Channels%" "$file")"
}

root=$(pwd)
if [ ! -d "$root" ]; then
	file="$root"
	Process-File "$file"
else
	Process-Folder "$root"
fi