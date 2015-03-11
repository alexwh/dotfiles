#!/usr/bin/env bash
set -o nounset # ie set -u
set -o errexit # ie set -e
imgur() {
	# TODO: use imgur account instead of app secret
	response=$(curl -sH "Authorization: Client-ID fdd3b8a687cc481" -F "image=@$1" "https://api.imgur.com/3/upload.xml")

	# TODO: don't hardcode to png - imgur auto jpgs over 1mb
	url="http://i.imgur.com/$(sed -r 's|.*<id>(.*)</id>.*|\1|' <<< $response).png"
	deleteurl="http://imgur.com/delete/$(sed -r 's|.*<deletehash>(.*)</deletehash>.*|\1|' <<< $response)"
	uploadtime=$(date +%F_%T)

	echo "$url"       >> ~/sync/misc/txt/imguruploads/${uploadtime}.txt
	echo "$deleteurl" >> ~/sync/misc/txt/imguruploads/${uploadtime}.txt
}
pomf() {
	# TODO: allow multiple file uploads?
	url=$(curl -sF "files[]=@$1" "http://pomf.se/upload.php?output=gyazo")
}
# TODO: s3 upload

site="$1";shift

# the rest of the args are now only files
for i;do
	$site "$i"
done
