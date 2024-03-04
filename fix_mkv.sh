#!/bin/bash

LastWeek=$(($(date +'%s') - 604800))

cd /tank/Movies/Library
for i in */*.mkv; do
	echo "$i"
	fileModifiedOn=$(stat "$i" -c %Y)
	if [[ "$fileModifiedOn" -gt "$LastWeek" ]]; then
		#modified
		mkvpropedit --add-track-statistics-tags "$i"
	else
		echo "Not recently modified"
	fi
done

cd /tank/Movies/Adult
for i in */*.mkv; do
	echo "$i"
	fileModifiedOn=$(stat "$i" -c %Y)
	if [[ "$fileModifiedOn" -gt "$LastWeek" ]]; then
		#modified
		mkvpropedit --add-track-statistics-tags "$i"
	else
		echo "Not recently modified"
	fi
done

cd /tank/TV-Shows/Library
for i in */*/*.mkv; do
	echo "$i"
	fileModifiedOn=$(stat "$i" -c %Y)
	if [[ "$fileModifiedOn" -gt "$LastWeek" ]]; then
		#modified
		mkvpropedit --add-track-statistics-tags "$i"
	else
		echo "Not recently modified"
	fi
done

cd /tank/TV-Shows/Zach
for i in */*/*.mkv; do
	echo "$i"
	fileModifiedOn=$(stat "$i" -c %Y)
	if [[ "$fileModifiedOn" -gt "$LastWeek" ]]; then
		#modified
		mkvpropedit --add-track-statistics-tags "$i"
	else
		echo "Not recently modified"
	fi
done

#Healthchecks.io
curl -m 10 --retry 5 https://hc-ping.com/f3d918bc-3ae4-49ef-8ae1-7f4f5431fe9e
