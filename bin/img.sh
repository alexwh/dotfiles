#!/usr/bin/env bash
set -o nounset # ie set -u
set -o errexit # ie set -e
notify() {
	notify-send "uploader" "$1"
}

# any command fails, we fail (set -e). notify about that
trap "notify 'Upload failed'" EXIT

uploadtype=$(echo -e "selection\nfull\nfile" | dmenu -p uploader)
file=$(mktemp /tmp/tmp.XXXXXXXXXX.png)

case "$uploadtype" in
	selection)
		maim -s -b 1 $file ;;
	full)
		maim $file ;;
	file)
		file=$(zenity --file-selection) ;;
esac

site=$(echo -e "imgur\npomf" | dmenu -p uploader)

notify "uploading"
url=$(~/bin/uploader.sh $site "$file")

echo -n "$url" | xclip -i -selection clipboard
notify "Copied link $url to clipboard"