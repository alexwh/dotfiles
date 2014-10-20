#!/usr/bin/env bash

# better regex:  "\"url\":\"(.+?)\""
# keeping this in case the gyazo output type dies or something
[[ -z "${1}" || ! -f "${1}" ]] && exit 1

output=$(curl -sf -F files[]="@${1}" "http://pomf.se/upload.php") || exit 2
if grep -q '"success":true,' <<< "$output"; then
	filename=$(sed -r 's|.*"url":"([A-Za-z0-9]+\.\w*)".*|\1|' <<< "$output")
	echo "http://a.pomf.se/${filename}"
else
	echo 'failed'
	exit 2
fi
