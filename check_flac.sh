#!/bin/bash
#For all flac files in the current directory, check BitDepth and SamplingRate and output those that are not 16bit 44100khz

#cd /tank/Audio/Music/
for input in *.flac
do
	if [ $(mediainfo --Inform="Audio;%BitDepth%" "$input") != "16" ]; then
		echo $input
		echo "Bit Depth: " $(mediainfo --Inform="Audio;%BitDepth%" "$input")
	fi

	if [ $(mediainfo --Inform="Audio;%SamplingRate%" "$input") != "44100" ]; then
		echo $input
		echo "Sampling Rate: " $(mediainfo --Inform="Audio;%SamplingRate%" "$input")
	fi
done

