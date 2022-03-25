#!/bin/bash
#For files in subfolders of Movies directory check x265 HDR codec information

cd /tank/DATA/Movies/
for input in */*
do
	if [ $(mediainfo --Inform="Video;%Format%" "$input") == "HEVC" ]; then
		echo $input
		echo "Video Format: " $(mediainfo --Inform="Video;%Format%" "$input")
		echo "Color Space: " $(mediainfo --Inform="Video;%ColorSpace%" "$input")
		echo "Chroma subsampling: " $(mediainfo --Inform="Video;%ChromaSubsampling%" "$input")
		echo "Bit Depth: " $(mediainfo --Inform="Video;%BitDepth%" "$input")
	fi
done

