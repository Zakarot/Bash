#!/bin/bash
#Convert video files with E-AC-3 audio to standard AC-3

for i in *.mkv
do
	if [ $(mediainfo --Inform="Audio;%Format%" "$i") == "E-AC-3" ]; then
		ffmpeg -i "$i" -c:v copy -c:a ac3 -b:a 192k -c:s copy -v 8 -stats "$i".mkv
		#rm "$i"
		#rename 's/.mkv.mp4/.mp4/' "$i".mp4
	fi
done
