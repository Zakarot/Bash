#!/bin/bash
#List all TV episodes that have E-AC-3 encoded audio

cd /tank/TV-Shows
for i in */*/*/*; do
    if [ $(mediainfo --Inform="Audio;%Format%" "$i") == "E-AC-3" ]; then
        echo "$i"
    fi
done
