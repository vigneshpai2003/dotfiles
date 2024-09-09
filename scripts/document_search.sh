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

substitution="<span color='#bebfc5' font_style='italic'>\\(\\2\\)<\\/span> \\3 <span color='pink' font_size='70%'>\\[\\1\\]<\\/span> <span color='skyblue' font_size='70%'>\\[\\4\\]<\\/span>"
substitution_pattern=$(echo $substitution | sed "s|\\\[0-9\]|(.*)|g")

path=`find $searchDir -type f -not -path '*/\.git*' -not -path '*/\.config*' | grep -E ".pdf|.djvu" | sed -E "s|$searchDir/||g;s|(.*)\/(.*)_ (.*)\.(.*)|$substitution|" | $wofi --dmenu`
path=`echo $path | sed -E "s|$substitution_pattern|\3/\1_ \2.\4|"`

if [[ -z "$path" ]]; then
    echo empty
else
    $viewer "$searchDir/$path" || $viewerBackup "$searchDir/$path"
fi
