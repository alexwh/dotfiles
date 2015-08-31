#!/bin/bash

backuppath="/data/backups/ssd"

start=$(date +%s)
rsync -aAXvP --del /* $backuppath/ --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/data/*,/lost+found,/home/*/.gvfs,/home/*/.thumbnails/*,/home/*/.cache/*} | tee $backuppath/rsyncoutput
end=$(date +%s)
echo -e "took $(( end-start )) seconds\n$(date '+done at %F %T')" > $backuppath/backupinfo
pacman -Qqn > $backuppath/basepkgs
pacman -Qqm > $backuppath/aurpkgs
pacman -Qqe > $backuppath/explpkgs
