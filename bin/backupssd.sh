#!/bin/bash

backuppath="/media/data/backups/ssd"

start=$(date +%s)
rsync -aAXvP --del /* $backuppath/ --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/home/*/.gvfs,/home/*/.thumbnails/*,/home/*/.cache/*}
end=$(date +%s)
echo -e "took $(( end-start )) seconds\n$(date '+done at %F %T')" > $backuppath/backupinfo
pacman -Qqn > $backuppath/basepkgs
pacman -Qqm > $backuppath/aurpkgs
pacman -Qqe > $backuppath/explpkgs
