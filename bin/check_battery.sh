#!/usr/bin/env bash
set -o pipefail
sleeptime=0
ret=0
tries=0
# mouse is connected
while [[ $ret -eq 0 ]]; do
    # https://github.com/alexwh/vaxee-read-battery
    mouse_pct=$(vaxee-read-battery)
    ret=$?
    # mouse is asleep
    if [[ $mouse_pct -eq 0 && $tries -lt 3 ]];then
        # 5800 is the number that kde actually shows this for to smoothly overlap for some reason
        notify-send --transient --icon /usr/share/icons/Tela-dark/symbolic/devices/input-mouse-symbolic.svg -t 5800 "Mouse unknown battery" "Move to wake for reading"
        sleep 5
        tries=$((tries + 1))
    else
        break
    fi
done
if [[ $ret -eq 0 && $mouse_pct -lt 26 ]]; then
    notify-send --transient --icon /usr/share/icons/Tela-dark/symbolic/devices/input-mouse-symbolic.svg -t 5800 "Mouse low battery" "Plug in to charge"
    sleeptime=5
fi
echo "mouse: ${mouse_pct}%"

headphones_mac=$(qdbus --system org.bluez|grep -E '^/org/bluez/hci.?/dev_80_C3_BA(_[A-F0-9]{2}){3}$')
headphones_connected=$(qdbus --system org.bluez "${headphones_mac}" org.bluez.Device1.Connected)
if [[ "${headphones_connected}" == "false" ]];then
    qdbus --system org.bluez "${headphones_mac}" org.bluez.Device1.Connect
fi
headphones_pct=$(dbus-send --print-reply=literal --system --dest=org.bluez "${headphones_mac}" org.freedesktop.DBus.Properties.Get string:"org.bluez.Battery1" string:"Percentage" | awk '{print $3}')
if [[ $? -eq 0 && $headphones_pct -lt 41 ]]; then
    notify-send --transient --icon /usr/share/icons/Tela-dark/symbolic/devices/headphones-symbolic.svg -t 5800 "Headphones low battery" "Plug in to charge"
    sleeptime=5
fi
echo "${headphones_mac}: ${headphones_pct}%"
sleep "${sleeptime}"
