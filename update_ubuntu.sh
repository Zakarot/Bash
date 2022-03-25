#!/bin/bash
#A simple Ubuntu/docker-compose update script

cd /docker

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

docker-compose pull
docker-compose up -d
docker image prune -f

echo reboot | sudo at 3:00
