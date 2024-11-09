#!/bin/sh -e

killall -SIGUSR1 gpu-screen-recorder || \
notify-send -t 5000 -u low -- "GPU Screen Recorder" "Replay failed to save"
