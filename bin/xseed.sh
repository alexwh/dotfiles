#!/bin/bash
# Script requires Pyroscope: http://code.google.com/p/pyroscope/wiki/QuickStartGuide?tm=2

announce=nah
dldir="/home/debian-transmission/downloads/"

[[ "$#" -lt 1 ]] && echo "Usage: $(basename "$0") .torrent [alt name]" && exit 1

# info.name is the top most file/folder name
torname=$(lstor -qo info.name "$1")
name="${2:-$torname}"

# times the piece size by 2 for a different hash
# info.piece length is in bytes. dividing by 1024 gives us the kib size. 512 is double that
torpiecesize=$(lstor -qo info.piece\ length "$1")
piecesize=$(bc <<< "$torpiecesize/2048" | cut -f1 -d.)
transmission-create -p -o "${name}_crossseed.torrent" -s "$piecesize" -t "$announce" "$dldir$name"
