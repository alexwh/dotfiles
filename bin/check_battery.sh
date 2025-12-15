#!/usr/bin/env bash
set -o pipefail
headphones_mac=$(qdbus --system org.bluez|grep -E '^/org/bluez/hci.?/dev_80_C3_BA(_[A-F0-9]{2}){3}$')
headphones_pct=$(dbus-send --print-reply=literal --system --dest=org.bluez "${headphones_mac}" org.freedesktop.DBus.Properties.Get string:"org.bluez.Battery1" string:"Percentage" | awk '{print $3}')
if [[ $? -eq 0 && $headphones_pct -lt 31 ]]; then
    notify-send --transient --icon /usr/share/icons/Tela-dark/symbolic/devices/headphones-symbolic.svg "Headphones low battery" "Plug in to charge"
fi
echo "${headphones_mac}: ${headphones_pct}%"

ret=0
# mouse is connected
while [[ $ret -eq 0 ]]; do
    # https://github.com/alexwh/vaxee-read-battery
    mouse_pct=$(vaxee-read-battery)
    ret=$?
    # mouse is asleep
    if [[ $mouse_pct -eq 0 ]];then
        # 5800 is the number that kde actually shows this for to smoothly overlap for some reason
        notify-send --transient --icon /usr/share/icons/Tela-dark/symbolic/devices/input-mouse-symbolic.svg -t 5800 "Mouse unknown battery" "Move to wake for reading"
        sleep 5
    else
        break
    fi
done
if [[ $ret -eq 0 && $mouse_pct -lt 26 ]]; then
    notify-send --transient --icon /usr/share/icons/Tela-dark/symbolic/devices/input-mouse-symbolic.svg "Mouse low battery" "Plug in to charge"
fi
echo "mouse: ${mouse_pct}%"
