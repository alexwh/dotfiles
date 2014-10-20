#!/bin/bash
pacman -Qeq > /home/alex/sync/misc/txt/$(hostname)packages.txt
echo -e "\n" >> /home/alex/sync/misc/txt/$(hostname)packages.txt
pacman -Qmq >> /home/alex/sync/misc/txt/$(hostname)packages.txt
