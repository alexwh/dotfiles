#!/usr/bin/env bash

[[ -z "$1" || ! -f "$1" ]] && exit 1
curl --retry 3 -sf -F files[]="@${1}" "http://pomf.se/upload.php?output=gyazo"
