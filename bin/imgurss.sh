#!/bin/bash

# TODO: dont hardcode png shit
# TODO: move file choosing functionality out of this script and just make it upload


# API Key provided by Alan@imgur.com
# apikey="b3625162d3418ac51a9ee805b1840452"

clientid=nah

notify() {
	notify-send "imgur" "$1"
}

choice=$(echo -e "select\nwindow\nfull\nfile" | dmenu -p imgur)

file=$(date '+/tmp/%F_%T.png')

case "$choice" in
	select)
		scrot -s $file ;;
	window)
		import -window "$(xdotool getwindowfocus -f)" $file ;;
	full)
		scrot $file ;;
	file)
		file=$(zenity --file-selection) ;;
	*)
		exit 1 ;;
esac
# fail and don't upload if selection canceled by keypress or no file selected
# (or some other cosmic incident that causes a failure)
[[ $? != 0 ]] && exit 1
notify "uploading"

response=$(curl -sH "Authorization: Client-ID $clientid" -F "image=@$file" https://api.imgur.com/3/upload.xml)
if [[ $? != 0 ]]; then
	notify "Upload failed"
	exit 2
elif grep -qo 'success="0"' <<< "$response"; then
	notify "Error message from imgur: $(sed -r 's|.*status="(.*)".*|\1|')"
	exit 2
fi

# parse the response and save our stuff
url="http://i.imgur.com/$(sed -r 's|.*<id>(.*)</id>.*|\1|' <<< $response).png"
deleteurl="http://imgur.com/delete/$(sed -r 's|.*<deletehash>(.*)</deletehash>.*|\1|' <<< $response)"

echo "$url"       >> ~/sync/misc/txt/imguruploads/$(date +%F_%T).txt
echo "$deleteurl" >> ~/sync/misc/txt/imguruploads/$(date +%F_%T).txt

echo -n "$url" | xclip -i -selection clipboard
notify "Copied link for $url to clipboard"

[[ $choice != "file" ]] && rm "$file"
