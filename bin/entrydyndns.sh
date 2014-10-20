#!/bin/bash

main=nah
archbook=nah
archbox=nah

curl -X PUT -d "" https://entrydns.net/records/modify/$main

[[ "$HOSTNAME" = "archbook" ]] && curl -X PUT -d "" https://entrydns.net/records/modify/$archbook

[[ "$HOSTNAME" = "archbox" ]] && curl -X PUT -d "" https://entrydns.net/records/modify/$archbox
