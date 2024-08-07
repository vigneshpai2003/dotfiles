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

calculate_charge_level () {
    if [[ $1 == $DISCHARGING_STR ]]; then
        if [[ $(charge_now) -le $CRITICAL ]]; then
            echo "critical"
        elif [[ $(charge_now) -le $WARNING ]]; then
            echo "warning"
        elif [[ $(charge_now) -le $LOW ]]; then
            echo "low"
        fi
    elif [[ $1 == $CHARGING_STR ]]; then
        if [[ $(charge_now) -ge $FULL ]]; then
            echo "full"
        elif [[ $(charge_now) -ge $ALMOST_FULL ]]; then
            echo "almost_full"
        fi
    fi
}

send_charge_level_notif () {
    if [[ $1 == "critical" ]]; then
        notify-send --urgency="critical" --icon="battery-action-symbolic" "Critical" "Battery is at $(charge_now)%."
    elif [[ $1 == "warning" ]]; then
        notify-send --icon="battery-caution-symbolic" "Warning" "Battery is at $(charge_now)%."
    elif [[ $1 == "low" ]]; then
        notify-send --icon="battery-020-symbolic" "Low Battery" "Battery is at $(charge_now)%."
    elif [[ $1 == "almost_full" ]]; then
        notify-send --icon="battery-good-charging" "Almost Full" "Battery is almost full at $(charge_now)%."
    elif [[ $1 == "full" ]]; then
        notify-send --icon="battery-full-charged" "Full" "Battery is full at $(charge_now)%."
    fi
}

CHARGE_LEVEL=$(calculate_charge_level $CHARGE_STATUS)

while true;
do
    # Check if the charge status has changed
    NEW_CHARGE_STATUS=`cat /sys/class/power_supply/$BATNAME/status`
    if [[ $CHARGE_STATUS != $NEW_CHARGE_STATUS ]]; then
        CHARGE_STATUS=$NEW_CHARGE_STATUS
        # Check if the battery is charging or discharging
        if [[ $CHARGE_STATUS == $CHARGING_STR ]]; then
            charging_message
        elif [[ $CHARGE_STATUS == $DISCHARGING_STR ]]; then
            discharging_message
        fi
    fi

    NEW_CHARGE_LEVEL=$(calculate_charge_level $CHARGE_STATUS)

    if [[ $CHARGE_LEVEL != $NEW_CHARGE_LEVEL ]]; then
        CHARGE_LEVEL=$NEW_CHARGE_LEVEL
        send_charge_level_notif $CHARGE_LEVEL
    fi

    sleep $POLLTIME
done
