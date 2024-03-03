#!/bin/bash
#Simple ffmpeg wrapper with my favorite options

#Settings to alwasy use
universalFfmpegFlags="-movflags +faststart -x265-params log-level=error -v 8 -stats"

excluldeFileTypes=".mp4"

#Audio/Video Output Settings
#outputFileType="mkv"
outputFileType="mp4"
##*Should* be "seemingly" lossless video
videoFfmpegFlags="-c:v libx265 -preset slow -crf 24"
#videoFfmpegFlags="-c:v libx264 -preset slow -crf 18:
##Average Quality video
#videoFfmpegFlags="-c:v libx264 -preset slow -crf 23"
##Audio
#audioFfmpegFlags="-c:a ac3 -b:a 640k"
audioFfmpegFlags="-c:a ac3"
#audioFfmpegFlags="-c:a copy"

##Audiobooks
#outputFileType="m4b"
#outputFileType="mp3"
#videoFfmpegFlags=""
#audioFfmpegFlags="-c:a copy"

Process-File() {
	#takes files indentified in Function Process-Folder, filters on included/excluded file types, and runs them through ffmpeg
	local file="$1"
	echo "Local File var is: $file"
	echo "Global excluldeFileTypes var is: $excluldeFileTypes"
	if [[ "$file" =~ "$excluldeFileTypes" ]]; then
		#Skip Excluded File Types
		echo "Skipped: $file"
	else
		echo "Processing: $file"
		$audioType=$(mediainfo --Inform="Audio;%Format%" "$file")
		$videoType=$(mediainfo --Inform="Video;%Format%" "$file")
		if [ $audioType == "AC-3" ]; then
			local audioFfmpegFlags="-c:a copy"
		fi
		if [ $videoType == "HEVC" ]; then
			local videoFfmpegFlags="-c:v copy"
		fi
		date
		ffmpeg -i "$file" $videoFfmpegFlags $audioFfmpegFlags $universalFfmpegFlags "$file"."$outputFileType"
		#read -n1 -r -p "Press any key to continue..." key
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
