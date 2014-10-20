#!/bin/bash

# API Key provided by Alan@imgur.com
apikey="b3625162d3418ac51a9ee805b1840452"

notify() {
	notify-send "imgur" "$1"
}

choice=$(echo -e "select\nwindow\nfull\nfile" | dmenu -p imgur)

file="/tmp/$(date +%F_%T).png"
sleep 1

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

# the "Expect: " header is to get around a problem when using this through
# the Squid proxy. Not sure if it's a Squid bug or what.
# TODO: use new imgur API
response=$(curl -F "key=$apikey" -H "Expect: " -F "image=@$file" http://imgur.com/api/upload.xml 2>/dev/null)
if [[ $? != 0 ]]; then
	notify "Upload failed"
	exit 2
elif [[ $(grep -c "<error_msg>" <<< $response) -gt 0 ]]; then
	notify "Error message from imgur: $(sed -r 's|.*<error_msg>(.*)</error_msg>.*|\1|' <<< $response)"
	exit 2
fi

# parse the response and save our stuff
url=$(sed -r 's|.*<original_image>(.*)</original_image>.*|\1|' <<< $response)
deleteurl=$(sed -r 's|.*<delete_page>(.*)</delete_page>.*|\1|' <<< $response)
echo "$url"       >> ~/sync/misc/txt/imguruploads/$(date +%F_%T).txt
echo "$deleteurl" >> ~/sync/misc/txt/imguruploads/$(date +%F_%T).txt

echo -n $url | xclip -i -selection clipboard
notify "Copied link for $url to clipboard"

[[ $choice != "file" ]] && rm "$file"
