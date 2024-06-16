#!/bin/sh
set -euo pipefail

(
while true;
do
    if fprintd-verify -f right-index-finger | grep "verify-match"
    then
        systemd-cat -t "vignesh@hyprlock" echo "Verified right-index-finger."
        break
    fi
    
    if fprintd-verify -f left-index-finger | grep "verify-match"
    then
        systemd-cat -t "vignesh@hyprlock" echo "Verified left-index-finger."
        break
    fi
done

pkill -USR1 hyprlock
systemd-cat -t "vignesh@hyprlock" echo "Unlocked."
) &

hyprlock --config ~/dotfiles/.config/hypr/hyprlock.conf

kill $(jobs -p)

pkill fprintd-verify