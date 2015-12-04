#!/usr/bin/env bash
set -o errexit # ie set -e
notify() {
	notify-send "uploader" "$1"
}

# any command fails, we fail (set -e). notify about that
trap '[[ $url ]] || notify "Upload failed"' EXIT

uploadtype=$(echo -e "selection\nfull\nfile" | dmenu -p uploader)
file=$(mktemp /tmp/$(date +%s)_XXXXXX.png)

case "$uploadtype" in
	selection)
		maim -s -b 1 $file ;;
	full)
		maim $file ;;
	file)
		file=$(zenity --file-selection) ;;
esac

site=$(echo -e "scp\nimgur" | dmenu -p uploader)

notify "uploading"
url=$(~/bin/uploader.sh $site "$file")

echo -n "$url" | xclip -i -selection clipboard
notify "Copied link $url to clipboard"
