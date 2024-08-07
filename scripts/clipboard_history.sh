#!/bin/sh
css=$DOTDIR/.config/wofi/style.css

# - substitute @username in css file
cp $css $css.tmp
sed -i "s|@dotdir|$DOTDIR|g" $css.tmp

wofi="wofi --conf $DOTDIR/.config/wofi/config --style $css.tmp"

cliphist list | $wofi --dmenu | cliphist decode | wl-copy