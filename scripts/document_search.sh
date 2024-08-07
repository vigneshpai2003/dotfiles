#!/bin/sh
home="/home/$(whoami)"
css=$DOTDIR/.config/wofi/style.css

# - substitute @username in css file
cp $css $css.tmp
sed -i "s|@dotdir|$DOTDIR|g" $css.tmp

wofi="wofi --conf $DOTDIR/.config/wofi/config --style $css.tmp --width 1200"

searchDir="$home/${1:-Documents}/Library"
viewer="papers"
viewerBackup="evince"

path=`find $searchDir -type f -not -path '*/\.git*' -not -path '*/\.config*' | grep -E ".pdf|.djvu" | sed -E "s|$searchDir/||g;s|(.*)\/(.*)_ (.*)\.(.*)|<span color='orange'>(\2)<\/span> \3 <span color='pink' font_size='70%'>[\1]<\/span>|" | $wofi --dmenu`

if [[ -z "$path" ]]; then
    echo empty
else
    $viewer "$searchDir/$path" || $viewerBackup "$searchDir/$path"
fi
