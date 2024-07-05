#!/bin/sh
timestamps=`dunstctl history | jq ".data[][].timestamp.data"`
IFS=$'\n' data=( $(dunstctl history | jq ".data[][].message.data" | sed 's|[""]||g;s|\\n| ▶ |g') )

dunst_ts_to_unix() {
	local dunst_ts=$(( $1 / 1000000))
	local seconds_uptime=$(date +%s -d@$(cut -d' ' -f1 /proc/uptime))
	local ts_now=$(date +%s)
	printf %d $((ts_now - seconds_uptime + dunst_ts))
}

i=0
for n in $timestamps; do
    echo "<i>" `date +'%a %T' -d@$(dunst_ts_to_unix "$n")` "</i>" ${data[i++]}
done
