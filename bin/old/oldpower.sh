cleanup() {
	killall transmission-gtk # wait to send trackers up/down totals
	killall firefox
	killall mpd
}

shutdown() {
	cleanup
	sudo systemctl poweroff
}

restart() {
	cleanup
	sudo systemctl reboot
}

logout() {
	cleanup
	i3-msg exit
}

lock() {
	initmloc=$(xdotool getmouselocation 2>/dev/null)

	# could be flimsy, don't know other output other than for my monitor (HDMI-X and DVI-X)
	i3barXname=$(xwininfo -root -children|grep -oE "i3bar for output .{3,4}.?[0-9]")

	for i in $(seq 5 -1 1);do
		# instalock if triggered by a $mod+key command
		xwininfo -name "$i3barXname" |& grep -q "Map State: IsViewable" && break
		
		# -t 50 might be wrong, notify-send is weird with expiring notifications
		notify-send -t 50 "locking in" "$i"
		sleep 1
		mloc=$(xdotool getmouselocation 2>/dev/null)

		if [[ $mloc != $initmloc ]];then
			notify-send "lock cancelled"
			exit 1
		fi
	done

	scrot /tmp/lock.png -e "convert /tmp/lock.png -blur 0x5 /tmp/lock.png"
	# killall -SIGUSR1 dunst
	sudo -k
	i3lock -i /tmp/lock.png --nofork --dpms --ignore-empty-password
	# i3lock -c 242424 --nofork --dpms --ignore-empty-password
	# rm /tmp/lock.png
	# killall -SIGUSR2 dunst
}

if [[ -z "$@" ]];then
	$(echo -e "shutdown\nrestart\nlogout\nlock" | dmenu -p power)
else
	for i;do
		$i
	done
fi
