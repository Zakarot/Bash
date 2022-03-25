#!/bin/bash
#Check mkv files in currect directory for audio format and number of channels.

for i in *.mkv; do
    echo "$i"
    mediainfo --Inform="Audio;%Format%" "$i"
    mediainfo --Inform="Audio;%Channels%" "$i"
done
