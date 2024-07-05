#!/bin/sh
home="/home/vignesh"
wofi="wofi --conf $home/dotfiles/.config/wofi/config --style $home/dotfiles/.config/wofi/library.css --width 1400"
path=`find ~/Documents/Library -type f -not -path '*/\.git*' | sed 's|/home/vignesh/Documents/Library||g' | $wofi --dmenu`

if [[ -z "$path" ]]; then
    echo empty
else
    evince "$home/Documents/Library$path"
fi
