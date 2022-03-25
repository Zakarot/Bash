#!/bin/bash
#Bulk delete ZFS snapshots

zfs list -H -o name -t snapshot $1
echo This will destroy all snapshots for $1
read -n1 -r -p "Press any key to continue... ^C to cancel..." key'
zfs list -H -o name -t snapshot $1 | xargs -n1 zfs destroy
