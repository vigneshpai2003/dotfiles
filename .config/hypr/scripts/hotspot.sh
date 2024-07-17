#!/bin/sh

WIFI_INTERFACE="wlp0s20f3"
INTERNET_INTERFACE="lo"
SSID="GarmJagah"
DEFAULT_PASSWORD="hotshots"

PASSWORD=${1:-$DEFAULT_PASSWORD}

pid=`sudo create_ap --list-running | awk '{printf $1}'`

if [[ -z "$pid" ]]; then
    notify-send "Starting hotspot..."
    if sudo create_ap $WIFI_INTERFACE $INTERNET_INTERFACE $SSID $PASSWORD --daemon; then
        sleep 5
        pid=`sudo create_ap --list-running | awk '{printf $1}'`
        if [[ -z "$pid" ]]; then
            notify-send "Failed to start hotspot." "Is Wi-Fi enabled?"
        else
            notify-send "Hotspot '$SSID' started." "PID: $pid"
        fi
    else
        notify-send "Failed to start hotspot." "An unknown error occurred."
    fi
else
    sudo create_ap --stop $pid
    notify-send "Hotspot stopped."
fi
