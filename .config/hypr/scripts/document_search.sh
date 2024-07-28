#!/bin/sh
home="/home/$(whoami)"
css=$DOTDIR/.config/wofi/library.css

# - substitute @username in css file
cp $css $css.tmp
sed -i "s|@dotdir|$DOTDIR|g" $css.tmp

wofi="wofi --conf $DOTDIR/.config/wofi/config --style $css.tmp --width 1400"

searchDir="$home/${1:-Documents}"
viewer="papers"
viewerBackup="evince"

path=`find $searchDir -type f -not -path '*/\.git*' -not -path '*/\.config*' | grep -E ".pdf|.djvu" | sed "s|$searchDir/||g" | $wofi --dmenu`

if [[ -z "$path" ]]; then
    echo empty
else
    $viewer "$searchDir/$path" || $viewerBackup "$searchDir/$path"
fi
