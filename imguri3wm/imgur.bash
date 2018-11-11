#!/bin/bash
# https://i.imgur.com/8QH0I6r.png 
# File uploaded - see your image at https://i.imgur.com/H0AcbNy.png
IMGURDIR=/home/devnull/Pictures/imgur
m="at (https://i.imgur.com/[^[:space:]]{1,7}.png)"
if [ ! -d $IMGURDIR ]; then 
	mkdir -p $IMGURDIR
fi
scrot -s '%s_%H%M_%d%m%Y_$wx$h.png' -e 'mv $f /home/devnull/Pictures/imgur'

recentimg="$(ls -t $IMGURDIR | head -1)"
imguri=$(imgur-uploader $IMGURDIR/$recentimg |  tail -n -1)

#echo $imguri
if [[ $imguri =~ $m ]]; then
	echo "${BASH_REMATCH[1]}" | xclip -selection clipboard
fi
