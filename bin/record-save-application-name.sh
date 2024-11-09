#!/bin/sh

# This script should be passed to gpu-screen-recorder with the -sc option, for example:
# gpu-screen-recorder -w screen -f 60 -a default_output -r 60 -sc scripts/record-save-application-name.sh -c mp4 -o "$HOME/Videos"

window=$(xdotool getwindowfocus)
window_name=$(xdotool getwindowclassname "$window" || xdotool getwindowname "$window" || echo "Desktop")
window_name="$(echo "$window_name" | tr '\0/\\' '_')"

video_dir="$HOME/Videos/shadowplay/$window_name"
mkdir -p "$video_dir"
video="$(date +"Replay_${window_name}_%Y-%m-%d_%H-%M-%S.mp4")"
mv "$1" "${video_dir}/${video}"
# sleep 0.5
notify-send -t 5000 -u low -- "GPU Screen Recorder" "Replay saved to $video"
