#!/bin/bash
#Simple ffmpeg wrapper with my favorite options

universalFlags="-movflags +faststart -x265-params log-level=error -v 8 -stats"

for i in *.mkv
do
	date
	echo "$i"
	###Remux
	#ffmpeg -i "$i" -c:v copy -c:a copy $universalFlags "$i".mkv

	###*Should* be "seemingly" lossless
	#ffmpeg -i "$i" -c:v libx265 -preset slow -crf 24 -c:a copy $universalFlags "$i".mkv
	ffmpeg -i "$i" -c:v libx265 -preset slow -crf 24 -c:a ac3 -b:a 640k $universalFlags "$i".mp4
	#ffmpeg -i "$i" -c:v libx264 -preset slow -crf 18 -c:a copy $universalFlags "$i".mp4
	#ffmpeg -i "$i" -c:v libx264 -preset slow -crf 18 -c:a ac3 -b:a 640k $universalFlags "$i".mp4

	###Average Quality
	#ffmpeg -i "$i" -c:v libx264 -preset slow -crf 23 -c:a copy $universalFlags "$i".mp4
	#ffmpeg -i "$i" -c:v libx264 -preset slow -crf 23 -c:a ac3 -b:a 640k $universalFlags "$i".mp4
done
date
