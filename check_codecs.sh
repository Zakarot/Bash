#!/bin/bash
#For each item in the current folder display important mediainfo

for i in *; do
    echo "$i"
    echo "Video Format: " $(mediainfo --Inform="Video;%Format%" "$i")
    echo "Video Bitrate: " $(mediainfo --Inform="Video;%BitRate/String%" "$i")
    echo "Video Pixels: " $(mediainfo --Inform="Video;%Height%" "$i")x$(mediainfo --Inform="Video;%Width%" "$i")
    echo "Color Primaries: " $(mediainfo --Inform="Video;%colour_primaries%" "$i")
    echo "Streamable: " $(mediainfo --Inform="General;%IsStreamable%" "$i")
    echo "Audio Format: " $(mediainfo --Inform="Audio;%Format%" "$i")
    echo "Audio Language: " $(mediainfo --Inform="Audio;%Language%" "$i")
    echo "Audio Channels: " $(mediainfo --Inform="Audio;%Channels%" "$i")
done
