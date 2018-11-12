#!/bin/bash
# https://i.imgur.com/8QH0I6r.png 
# File uploaded - see your image at https://i.imgur.com/H0AcbNy.png
IMGURDIR=/home/devnull/Pictures/imgur
LISTUPLOADED=/home/devnull/Pictures/imgur/uploaded_list
m="at (https://i.imgur.com/[^[:space:]]{1,7}.png)"
if [ ! -d $IMGURDIR ]; then 
	mkdir -p $IMGURDIR
fi
scrot -s '%s_%H%M_%d%m%Y_$wx$h.png' -e 'mv $f /home/devnull/Pictures/imgur'

recentimg="$(ls -t $IMGURDIR | grep -v "uploaded_list" | head -1)"
imguri=$(imgur-uploader $IMGURDIR/$recentimg |  tail -n -1)
#remove screenshoot after uploding to give more disk space
rm "$IMGURDIR"/"$recentimg"

if [[ $imguri =~ $m ]]; then
	match="${BASH_REMATCH[1]}"
	echo "$match - $recentimg" >> $LISTUPLOADED
	echo "$match" | xclip -selection clipboard -i
	
fi
