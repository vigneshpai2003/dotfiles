#!/bin/sh

WIFI_INTERFACE="wlp0s20f3"
INTERNET_INTERFACE="lo"
SSID="GarmJagah"
DEFAULT_PASSWORD="hotshots"

PASSWORD=${1:-$DEFAULT_PASSWORD}

pid=`sudo create_ap --list-running | awk '{printf $1}'`

if [[ -z "$pid" ]]; then
    if sudo create_ap $WIFI_INTERFACE $INTERNET_INTERFACE $SSID $PASSWORD --daemon; then
        notify-send "Hotspot started."
    else
        notify-send "Failed to start hotspot."
    fi
else
    sudo create_ap --stop $pid
    notify-send "Hotspot stopped."
fi
