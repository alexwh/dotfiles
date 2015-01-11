#!/usr/bin/env bash

notify() {
	notify-send "uploader" "$1"
}
imgur() {
	# API Key provided by Alan@imgur.com
	# apikey="b3625162d3418ac51a9ee805b1840452"
	imgurclientid="7d5235bd5e09cd2"

	response=$(curl -sH "Authorization: Client-ID $imgurclientid" -F "image=@$1" https://api.imgur.com/3/upload.xml)

	# parse the response and save our stuff
	# TODO: don't hardcode to png
	url="http://i.imgur.com/$(sed -r 's|.*<id>(.*)</id>.*|\1|' <<< $response).png"
	deleteurl="http://imgur.com/delete/$(sed -r 's|.*<deletehash>(.*)</deletehash>.*|\1|' <<< $response)"

	echo "$url"       >> ~/sync/misc/txt/imguruploads/$(date +%F_%T).txt
	echo "$deleteurl" >> ~/sync/misc/txt/imguruploads/$(date +%F_%T).txt
}
pomf() {
	# TODO: allow multiple file uploads?
	url=$(curl --retry 3 -s -F files[]="@${1}" "http://pomf.se/upload.php?output=gyazo")
}

site=$(echo -e "imgur\npomf" | dmenu -p uploader)
choice=$(echo -e "select\nwindow\nfull\nfile" | dmenu -p uploader)
file=$(mktemp /tmp/tmp.XXXXXXXXXX.png)

case "$choice" in
	select)
		maim -s $file ;;
	window)
		maim -i "$(xdotool getactivewindow)" $file ;;
	full)
		maim $file ;;
	file)
		file=$(zenity --file-selection) ;;
	*)
		exit 1 ;;
esac

# fail and don't upload if selection canceled by keypress or no file selected
# (or some other cosmic incident that causes a failure)
[[ $? != 0 ]] && exit 1
notify "uploading"

$site "$file"

if [[ $? != 0 ]]; then
	notify "Upload failed"
	exit 2
fi

echo -n "$url" | xclip -i -selection clipboard
notify "Copied link for $url to clipboard"

[[ $choice != "file" ]] && rm "$file"
