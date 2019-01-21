#!/usr/bin/env bash
set -o nounset # ie set -u
set -o errexit # ie set -e
imgur() {
    # TODO: use imgur account instead of app secret
    response=$(curl -sw '\n' -H "Authorization: Client-ID fdd3b8a687cc481" -F "image=@$1" "https://api.imgur.com/3/upload.xml")

    url="$(sed -r 's|.*<link>(.*)</link>.*|\1|' <<< $response)"
    deleteurl="http://imgur.com/delete/$(sed -r 's|.*<deletehash>(.*)</deletehash>.*|\1|' <<< $response)"
    uploadtime=$(date +%F_%T)

    echo "$url"       >> ~/sync/misc/txt/imguruploads/${uploadtime}.txt
    echo "$deleteurl" >> ~/sync/misc/txt/imguruploads/${uploadtime}.txt
    echo $url
}
scp() {
    scpupload.sh "$@"
}

site="$1";shift

# the rest of the args are now only files
for i;do
    $site "$i"
done
