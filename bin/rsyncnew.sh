#!/usr/bin/env bash
set -o nounset # ie set -u
set -o errexit # ie set -e
server="$1"
src="$2"
dest="$3"

# -r needs to be explicit with --files-from
# %P in find is just the basepath of the match (so we don't create massive folder structure in $dest)
rsync -rptvhP --info=progress2 --files-from=<(ssh "$server" find "$src" -mtime -1 -maxdepth 1 -mindepth 1 -printf '%P\\n') "$server":"$src" "$dest"
