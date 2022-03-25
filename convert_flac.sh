#!/bin/bash
#Convert WAV and FLAC files to FLAC with max compression, 16bit, 44100Khz

for input in *
do
        echo "##########################################################################################################"
	skip="no"
        #Convert Name
        output="$input"

        case "$input" in
        *.wav)
                output=$(basename -s .wav "$input")
                ;;
        *.flac)
                output=$(basename -s .flac "$input")
		mv "$input" "$output.old.flac"
		input="$output.old.flac"
                ;;
	*)
		echo "Input file "$input" is not flac"
		skip="yes"
		;;
        esac
	if [ "$skip" != "yes" ]; then 
	        output="$output.flac"
	        echo "Converting $input to $output"

		ffmpeg -v quiet -stats -analyzeduration 2147483647 -probesize 2147483647 -i "$input" -c:a flac -compression_level 12 -sample_fmt s16 -ar 44100 "$output"
	fi
done

