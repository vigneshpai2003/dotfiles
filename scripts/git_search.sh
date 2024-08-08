#!/bin/sh
css=$DOTDIR/.config/wofi/style.css

# - substitute @username in css file
cp $css $css.tmp
sed -i "s|@dotdir|$DOTDIR|g" $css.tmp

wofi="wofi --conf $DOTDIR/.config/wofi/config --style $css.tmp"

substitution="<span>\\2</span> <span color='pink' font_size='70%'>\[\\1\]<\/span>"
substitution_pattern=$(echo $substitution | sed "s|\\\[0-9\]|(.*)|g")
echo $substitution_pattern

path=`find ~/Desktop ~/Documents ~/Downloads ~/Projects ~/dotfiles -name ".git" | sed -E "s|(.*)/(.*)/.git|$substitution|" | $wofi --dmenu`
path=`echo $path | sed -E "s|$substitution_pattern|\2\/\1|"`

if [[ -z "$path" ]]; then
    echo empty
else
    code -n $path
fi
