#!/usr/bin/env bash

#########################################################################################
#What day of the week do you want to take the weekly snapshot? Default = Friday(5)	#
if [ $HOSTNAME = "archbook" ];then
	weekly_dow=2
else
	weekly_dow=5
fi
#What hour of the day to you want to take the daily snapshot? Default = 11PM (23)
daily_time=18
#Do you want to use UTC time? (1 = Yes) Default = 0, use local time.
USE_UTC=0
#Path to GNU date binary (e.g. /bin/date on Linux, /usr/local/bin/gdate on FreeBSD)
DATE_BIN=$(which date)
#########################################################################################
usage ()
{
cat << EOF
usage: $0 arguments

This script manages Tarsnap backups
EOF
}

notif() {
	DISPLAY=:0.0 sudo -u alex notify-send "$@"
}

hourly_cnt=1
daily_cnt=1
weekly_cnt=2
monthly_cnt=1

#Set some constants
#The day of the week (Monday = 1, Sunday = 7)
DOW=$($DATE_BIN +%u)
#The calendar day of the month
DOM=$($DATE_BIN +%d)
#The last day of the current month. I wish there was a better way to do this, but this seems to work everywhere.
LDOM=$(echo $(cal) | awk '{print $NF}')
#We need 'NOW' to be constant during execution, we set it here.
NOW=$($DATE_BIN +%Y%m%d-%H)
CUR_HOUR=$($DATE_BIN +%H)
if [ "$USE_UTC" = "1" ];then
	NOW=$($DATE_BIN -u +%Y%m%d-%H)
	CUR_HOUR=$($DATE_BIN -u +%H)
fi

#Find the backup type (hourly|daily|weekly|MONTHY)
BK_TYPE=hourly	#Default to hourly
if ( [ "$DOM" = "$LDOM" ] && [ "$CUR_HOUR" = "$daily_time" ] );then
	BK_TYPE=monthly
else
	if ( [ "$DOW" = "$weekly_dow" ] && [ "$CUR_HOUR" = "$daily_time" ] );then
		BK_TYPE=weekly
	else
		if [ "$CUR_HOUR" = "$daily_time" ];then
			BK_TYPE=daily
		fi
	fi
fi

echo "Starting $BK_TYPE backups..."
notif "Tarsnap" "Starting $BK_TYPE backups..."

for dir;do
	tarsnap -v -c -f $NOW-$BK_TYPE-$(hostname -s)-$(echo $dir) --one-file-system -C / $dir
	if [ $? = 0 ];then
		notif "Tarsnap" "$NOW-$BK_TYPE-$(hostname -s)-$(echo $dir) backup done."
	else
		notif "Tarsnap" "$NOW-$BK_TYPE-$(hostname -s)-$(echo $dir) backup error. Exiting";exit $?
	fi
done

#Check to make sure the last set of backups are OK.
archive_list=$(tarsnap --list-archives)

for dir;do
	case "$archive_list" in
		*"$NOW-$BK_TYPE-$(hostname -s)-$(echo $dir)"* )
			echo "$NOW-$BK_TYPE-$(hostname -s)-$(echo $dir) backup OK." ;;
		* )
			notif "Tarsnap" "$NOW-$BK_TYPE-$(hostname -s)-$(echo $dir) backup NOT OK. Check --archive-list."; exit 3 ;;
	esac
done

#Delete old backups
hourly_delete_time=$($DATE_BIN -d"-$hourly_cnt hour" +%Y%m%d-%H)
daily_delete_time=$($DATE_BIN -d"-$daily_cnt day" +%Y%m%d-%H)
weekly_delete_time=$($DATE_BIN -d"-$weekly_cnt week" +%Y%m%d-%H)
monthly_delete_time=$($DATE_BIN -d"-$monthly_cnt month" +%Y%m%d-%H)

echo "Finding backups to be deleted."

if [ $BK_TYPE = "hourly" ];then
	for backup in $archive_list;do
		case "$backup" in
			"$hourly_delete_time-$BK_TYPE"* )
				case "$backup" in   #this case added to make sure the script doesn't delete the backup it just took. Case: '-h x' and backup takes > x hours. 
					*"$NOW"* ) echo "Skipped $backup" ;;
					* )  tarsnap -d -f $backup
						if [ $? = 0 ];then
							notif "Tarsnap" "$backup snapshot deleted."
							echo "$backup snapshot deleted."
						else
							notif "Tarsnap" "Unable to delete $backup. Exiting";exit $?
							echo "Unable to delete $backup. Exiting";exit $?
						fi ;;
				esac ;;
			* ) ;;
		esac
	done
fi


if [ $BK_TYPE = "daily" ];then
	for backup in $archive_list;do
		case "$backup" in
			"$daily_delete_time-$BK_TYPE"* )
				case "$backup" in
					*"$NOW"* ) echo "Skipped $backup" ;;
				* )  tarsnap -d -f $backup
					if [ $? = 0 ];then
						notif "Tarsnap" "$backup snapshot deleted."
						echo "$backup snapshot deleted."
					else
						notif "Tarsnap" "Unable to delete $backup. Exiting";exit $?
						echo "Unable to delete $backup. Exiting";exit $?
					fi ;;
			esac ;;
		* ) ;;
	esac
done
fi

if [ $BK_TYPE = "weekly" ];then
	for backup in $archive_list;do
		echo backup name
		echo $backup
		echo delete time-type
		echo $weekly_delete_time-$BK_TYPE
		case "$backup" in
			"$weekly_delete_time-$BK_TYPE"* )
				case "$backup" in
					*"$NOW"* ) echo "Skipped $backup" ;;
				* ) tarsnap -d -f $backup
					if [ $? = 0 ];then
						notif "Tarsnap" "$backup snapshot deleted."
						echo "$backup snapshot deleted."
					else
						notif "Tarsnap" "Unable to delete $backup. Exiting";exit $?
						echo "Unable to delete $backup. Exiting";exit $?
					fi ;;
			esac ;;
		* ) echo did not hit delete time bktype ;;
	esac
done
fi

if [ $BK_TYPE = "monthly" ];then
	for backup in $archive_list;do
		case "$backup" in
			"$monthly_delete_time-$BK_TYPE"* )
				case "$backup" in
					*"$NOW"* ) echo "Skipped $backup" ;;
				* ) tarsnap -d -f $backup
					if [ $? = 0 ];then
						notif "Tarsnap" "$backup snapshot deleted."
						echo "$backup snapshot deleted."
					else
						notif "Tarsnap" "Unable to delete $backup. Exiting";exit $?
						echo "Unable to delete $backup. Exiting";exit $?
					fi ;;
			esac ;;
		* ) ;;
	esac
done
fi
