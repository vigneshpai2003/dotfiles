#!/bin/sh

WIFI_INTERFACE="wlp0s20f3"
INTERNET_INTERFACE="lo"
SSID="GarmJagah"
DEFAULT_PASSWORD="hotshots"

PASSWORD=${1:-$DEFAULT_PASSWORD}

pid=`sudo create_ap --list-running | awk '{printf $1}'`

if [[ -z "$pid" ]]; then
    notify-send --print-id --icon="network-wireless-acquiring-symbolic" "Starting hotspot..."
    if sudo create_ap $WIFI_INTERFACE $INTERNET_INTERFACE $SSID $PASSWORD --daemon; then
        sleep 5
        pid=`sudo create_ap --list-running | awk '{printf $1}'`
        if [[ -z "$pid" ]]; then
            notify-send --print-id --icon="network-wireless-error-symbolic" "Failed to start hotspot." "Is Wi-Fi enabled?"
        else
            notify-send --print-id --icon="network-wireless-hotspot-symbolic" "Hotspot '$SSID' started." "PID: $pid"
        fi
    else
        notify-send --icon="network-wireless-error-symbolic" "Failed to start hotspot." "An unknown error occurred."
    fi
else
    sudo create_ap --stop $pid
    notify-send --icon="network-wireless-disabled-symbolic" "Hotspot stopped."
fi
