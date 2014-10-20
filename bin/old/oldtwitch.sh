#!/bin/bash
#
# twitch.sh by fau <faltec@gmail.com>
# Depends on curl and rtmpdump
# You may need to use latest version of rtmpdump which allows --jtv option

read_dom () {
	local IFS=\>
	read -d \< ENTITY CONTENT
}

if [[ ! -n "$1" || "$1" = "-h" || "$1" = "--help" ]]; then
	echo "Usage: twitch.sh channelname"
	echo ""
	echo "Example: twitch.sh zronvc | mplayer -"
	echo "Warning: Channel name can be found in stream's url and may be different than name displayed on webpage."
	exit
fi

wget -O /tmp/twitch.$1.xml "http://usher.twitch.tv/find/$1.xml?type=live" &> /dev/null

while read_dom; do
	if [[ "$ENTITY" = "play" ]]; then
		PLAYPATH="$CONTENT"
	elif [[ "$ENTITY" = "token" ]]; then
		TOKEN="$CONTENT"
	elif [[ "$ENTITY" = "connect" ]]; then
		RTMP="$CONTENT"
	fi
done < /tmp/twitch.$1.xml &> /dev/null

rm -f /tmp/twitch.$1.xml &> /dev/null

if [ ! -n "$RTMP" ]; then
	notify-send "There are no live streams on channel $1"
	exit 1
fi

PLAYER=$(curl -s -L -w %{url_effective} -r 0-0 http://www-cdn.jtvnw.net/widgets/live_site_player.swf \
	| cut -c 2- | cut -d \? -f 1)

rtmpdump --quiet \
	--rtmp "$RTMP" \
	--playpath "$PLAYPATH" \
	--jtv "$TOKEN" \
	--swfVfy "$PLAYER" \
	--live \
	--realtime \
	-o - | mpv -cache-min 10 - &> /dev/null &
