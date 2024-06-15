#!/bin/sh
set -euo pipefail
(
until fprintd-verify -f right-index-finger | grep "verify-match" || fprintd-verify -f left-index-finger | grep "verify-match"; do
    echo "hyprlock: Failed to verify fingerprint at $(date)" | systemd-cat
done
echo "hyprlock: Unlocked at $(date)" | systemd-cat
pkill -USR1 hyprlock
) &
hyprlock --config ~/dotfiles/.config/hypr/hyprlock.conf
kill $(jobs -p)
pkill fprintd-verify