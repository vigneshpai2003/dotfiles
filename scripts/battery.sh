#!/bin/sh
BATNAME="BAT0"
POLLTIME=5

CRITICAL=5
WARNING=10
LOW=20
ALMOST_FULL=85
FULL=99

CHARGE_FULL=`cat /sys/class/power_supply/$BATNAME/charge_full`
CHARGE_STATUS=`cat /sys/class/power_supply/$BATNAME/status`
CHARGING_STR="Charging"
DISCHARGING_STR="Discharging"

charge_now () {
    echo `expr $(cat /sys/class/power_supply/$BATNAME/charge_now) \* 100 / $CHARGE_FULL`
}

icon_number () {
    printf "%0.3d" $(expr $(charge_now) / 10 \* 10)
}

charging_message () {
    icon="battery-$(icon_number)-charging"
    notify-send --icon=$icon "Charging" "Battery is charging at $(charge_now)%."
}

discharging_message () {
    icon="battery-$(icon_number)-symbolic"
    notify-send --icon="$icon" "Discharging" "Battery is discharging at $(charge_now)%."
}

while true;
do
    # Check if the charge status has changed
    NEW_CHARGE_STATUS=`cat /sys/class/power_supply/$BATNAME/status`
    if [ $CHARGE_STATUS != $NEW_CHARGE_STATUS ]; then
        if [ $NEW_CHARGE_STATUS == $CHARGING_STR ]; then
            charging_message
        elif [ $NEW_CHARGE_STATUS == $DISCHARGING_STR ]; then
            discharging_message
        fi
        CHARGE_STATUS=$NEW_CHARGE_STATUS
    fi

    if [ $CHARGE_STATUS == $DISCHARGING_STR ]; then
        # Check if the battery is low
        if [ $(charge_now) -le $LOW ]; then
            notify-send --icon="battery-020-symbolic" "Low Battery" "Battery is at $(charge_now)%."
        elif [ $(charge_now) -le $WARNING ]; then
            notify-send --icon="battery-caution-symbolic" "Warning" "Battery is at $(charge_now)%."
        elif [ $(charge_now) -le $CRITICAL ]; then
            notify-send --urgency="critical" --icon="battery-action-symbolic" "Critical" "Battery is at $(charge_now)%."
        fi
    
    elif [ $CHARGE_STATUS == $CHARGING_STR ]; then
        # Check if the battery is charged
        if [ $(charge_now) -ge $FULL ]; then
            notify-send --icon="battery-full-charged" "Full" "Battery is full at $(charge_now)%."
        elif [ $(charge_now) -ge $ALMOST_FULL ]; then
            notify-send --icon="battery-good-charging" "Almost Full" "Battery is almost full at $(charge_now)%."
        fi
    fi

    sleep $POLLTIME
done
