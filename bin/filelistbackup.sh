#!/bin/bash
find / | aescrypt -e -p "$(< /home/alex/.config/aescrypt.pass)" -o /home/alex/sync/misc/txt/$(hostname)filelist.txt.aes -
