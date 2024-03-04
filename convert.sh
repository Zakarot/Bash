#!/bin/bash

inputDir="$1"
outputDir="$2"

cd "$inputDir"
mkdir -p "$outputDir"

universalFlags="-movflags +faststart -x265-params log-level=error -v 8 -stats"

for i in *.mkv
do
	date
	echo "$i"
	###Remux
	#ffmpeg -i "$i" -c:v copy -c:a copy $universalFlags "$outputDir"/"$i".mkv
	#ffmpeg -i "$i" -c:v libx265 -crf 24 -c:a copy $universalFlags "$outputDir"/"$i".mkv
	ffmpeg -i "$i" -c:v libx265 -b:v 3000k -c:a ac3 -b:a 640k $universalFlags "$outputDir"/"$i".mkv
	mkvpropedit --add-track-statistics-tags "$outputDir"/"$i".mkv
done
date
