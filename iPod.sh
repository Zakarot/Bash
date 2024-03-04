#!/bin/bash
#Convert Music Library for iPod

inputRootFolder="/tank/Audio/Music"
outputRootFolder="/tmp/Music"

convertFlacToMp3() {
	file="$1"
	sourceFolder=$(pwd)
	destinationFolder=$(echo "$sourceFolder" | sed "s|$inputRootFolder|$outputRootFolder|")
	mkdir -p "$destinationFolder"
	if [ ! -f "$destinationFolder/$file.mp3" ]; then
		ffmpeg -v 8 -stats -i "$sourceFolder/$file" -f mp3 -c:a mp3 -q:a 0 "$destinationFolder/$file.mp3"
	fi
}

copyMp3ToMp3() {
	file="$1"
	sourceFolder=$(pwd)
	destinationFolder=$(echo "$sourceFolder" | sed "s|$inputRootFolder|$outputRootFolder|")
	mkdir -p "$destinationFolder"
	if [ ! -f "$destinationFolder/$file" ]; then
		rsync --progress "$sourceFolder/$file" "$destinationFolder/$file"
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

Process-File() {
	#Processes files indentified in Function Process-Folder 
	local file="$1"
	echo "$file"
	case "$file" in	
	*.flac)
		convertFlacToMp3 "$file"
		;;
	*.mp3)
		copyMp3ToMp3 "$file"
		;;
	*)
		;;
	esac
}

root="$inputRootFolder"
mkdir -p "$outputRootFolder"
if [ ! -d "$root" ]; then
	file="$root"
	Process-File "$file"
else
	Process-Folder "$root"
fi