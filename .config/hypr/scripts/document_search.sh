#!/bin/sh
home="/home/vignesh"
wofi="wofi --conf $home/dotfiles/.config/wofi/config --style $home/dotfiles/.config/wofi/library.css --width 1400"

searchDir="$home/${1:-Documents}"
viewer="papers"
viewerBackup="evince"

path=`find $searchDir -type f -not -path '*/\.git*' -not -path '*/\.config*' | grep -E ".pdf|.djvu" | sed "s|$searchDir/||g" | $wofi --dmenu`

if [[ -z "$path" ]]; then
    echo empty
else
    $viewer "$searchDir/$path" || $viewerBackup "$searchDir/$path"
fi
