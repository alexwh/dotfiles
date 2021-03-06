#!/usr/bin/env bash
# this is a (heavily) modified/simplified version of https://github.com/Gestas/Tarsnap-generations

# times need to be constant during execution
now=$(date +%s)
delete_time=$(date -d"-1 week" +%s)

# when for has no extra args, it defaults to "$@"
for dir;do
    tarsnap -v -c -f "${now}_${HOSTNAME}-${dir}" --one-file-system -C / "$dir"
    if [[ $? -eq 0 ]];then
        echo "${now}_${HOSTNAME}-${dir} backup done."
    else
        echo "${now}_${HOSTNAME}-${dir} backup error. Exiting";exit $?
    fi
done

archive_list=$(tarsnap --list-archives)

# Check to make sure the last set of backups are OK.
for dir;do
    if grep -q "${now}_${HOSTNAME}-${dir}" <<< "$archive_list";then
        echo "${now}_${HOSTNAME}-${dir} backup OK."
    else
        echo "${now}_${HOSTNAME}-${dir} backup NOT OK. Check --archive-list."; exit 3
    fi
done

for backup in $archive_list;do
    backup_time=$(cut -d _ -f1 <<< "$backup")

    if [[ $backup_time -lt $delete_time ]];then
        tarsnap -d -f "$backup"
        if [[ $? -eq 0 ]];then
            echo "$backup snapshot deleted."
        else
            echo "Unable to delete $backup. Exiting";exit $?
        fi
    fi
done

echo "Done"
