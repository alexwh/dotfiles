#!/bin/sh

# This script should be passed to gpu-screen-recorder with the -sc option, for example:
# gpu-screen-recorder -w screen -f 60 -a default_output -r 60 -sc scripts/record-save-application-name.sh -c mp4 -o "$HOME/Videos"

window=$(kdotool getactivewindow)
window_name=$(kdotool getwindowclassname "$window" || kdotool getwindowname "$window" || echo "Desktop")
window_name="$(echo "$window_name" | tr '\0/\\' '_')"

video_dir="$HOME/Videos/shadowplay/$window_name"
mkdir -p "$video_dir"
video="$(date +"Replay_left_${window_name}_%Y-%m-%d_%H-%M-%S.mp4")"
mv "$1" "${video_dir}/${video}"
# sleep 0.5
action=$(notify-send -t 5000 -u low --action "Open file" --action "Open folder" -- "GPU Screen Recorder" "Replay saved to $video")
if [[ "$action" == "0" ]];then
    xdg-open "${video_dir}/${video}"
elif [[ "$action" == "1" ]];then
    xdg-open "${video_dir}"
fi
