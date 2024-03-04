#!/bin/bash
#For all flac files, check BitDepth and SamplingRate and output those that are not 16bit 44100khz

Process-Folder() {
	#Takes single file/folder parameter and checks to see which if any child objects are folders and recursively calls the function on them.
	#This allows the main process to use this function to process an indeterminate number of subfolders looking for files to process.
	local folder="$1"
	cd "$folder"
	for item in *
	do
		if [ -d "$item" ]; then
			Process-Folder "$item"
		elif [[ "$item" =~ ".flac" ]]; then
			Process-File "$item"
		fi
	done
	cd ../
}

Process-File() {
	#Processes files indentified in Function Process-Folder 
	local file="$1"
	local BitDepth=$(mediainfo --Inform="Audio;%BitDepth%" "$file")
	local sampleRate=$(mediainfo --Inform="Audio;%SamplingRate%" "$file")
	if [ "$BitDepth" != "16" ] | [ "$sampleRate" != "44100" ]; then
		echo "$(pwd)/$file"
		echo "Bit Depth: $BitDepth"
		echo "Sampling Rate: $sampleRate"
	fi
}
		
root=$(pwd)
if [ ! -d "$root" ]; then
	file="$root"
	Process-File "$file"
else
	Process-Folder "$root"
fi