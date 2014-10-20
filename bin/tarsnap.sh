#!/usr/bin/env bash

notify() {
	DISPLAY=:0.0 sudo -u alex notify-send "Tarsnap" "$@"
}

date_bin=$(which date)
# 'now' needs to be constant during execution
now=$($date_bin +%s)

notify "Starting tarsnap backups..."

for dir;do
	tarsnap -v -c -f "${now}_${HOSTNAME}-${dir}" --one-file-system -C / $dir
	if [ $? = 0 ];then
		echo "${now}_${HOSTNAME}-${dir} backup done."
		notify "${now}_${HOSTNAME}-${dir} backup done."
	else
		echo "${now}_${HOSTNAME}-${dir} backup error. Exiting";exit $?
		notify "${now}_${HOSTNAME}-${dir} backup error. Exiting";exit $?
	fi
done

archive_list=$(tarsnap --list-archives)

# Check to make sure the last set of backups are OK.
for dir;do
	if grep -q "${now}_${HOSTNAME}-${dir}" <<< $archive_list;then
		echo "${now}_${HOSTNAME}-${dir} backup OK."
	else
		echo "${now}_${HOSTNAME}-${dir} backup NOT OK. Check --archive-list."; exit 3
		notify "${now}_${HOSTNAME}-${dir} backup NOT OK. Check --archive-list."; exit 3
	fi
done

# Delete backups older than a week
delete_time=$($date_bin -d"-1 week" +%s)

for backup in $archive_list;do
	backup_time=$(cut -d _ -f1 <<< $backup)

	if [[ $backup_time -lt $delete_time ]];then
		tarsnap -d -f $backup
		if [ $? = 0 ];then
			echo "$backup snapshot deleted."
			notify "$backup snapshot deleted."
		else
			echo "Unable to delete $backup. Exiting";exit $?
			notify "Unable to delete $backup. Exiting";exit $?
		fi
	fi
done

notify "Done"
