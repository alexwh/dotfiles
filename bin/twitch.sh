#!/bin/bash
die() {
	notify-send "No streams on $1"
}

if [[ -z $2 ]];then
	qual="source"
else
	qual=$2
fi
livestreamer -p mpv twitch.tv/$1 $qual || die "$@"
