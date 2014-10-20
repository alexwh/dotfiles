#!/bin/bash

backuppath="/media/data/backups/ssd"
opts="-aAXvP --del"

start=$(date +%s)
rsync $opts /* $backuppath/ --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/home/*/.gvfs,/home/*/.thumbnails/*,/home/*/.cache/chromium/*,/home/*/.cache}
end=$(date +%s)
echo -e "took $(( end-start )) seconds\n\
date '+done at %F %T'"> $backuppath/backupinfo
pacman -Qqn > $backuppath/basepkgs
pacman -Qqm > $backuppath/aurpkgs
pacman -Qqe > $backuppath/explpkgs
