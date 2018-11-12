#!/bin/bash
# https://i.imgur.com/8QH0I6r.png 
# File uploaded - see your image at https://i.imgur.com/H0AcbNy.png
#path of the screenshot
IMGURDIR=/home/devnull/Pictures/imgur

#list url of uploaded image at imgur
LISTUPLOADED=/home/devnull/Pictures/imgur/uploaded_list
m="at (https://i.imgur.com/[^[:space:]]{1,7}.png)"
if [ ! -d $IMGURDIR ]; then 
	mkdir -p $IMGURDIR
fi
#scrot -s '%s_%H%M_%d%m%Y_$wx$h.png' -e 'mv $f /home/devnull/Pictures/imgur'

#taking screenshot
deepin-screenshot -n -s $IMGURDIR/$(date '+%d%m%Y_%W-%H-%S') &> /dev/null
recentimg="$(ls -t $IMGURDIR | grep -v "uploaded_list" | head -1)"
imguri=$(imgur-uploader $IMGURDIR/$recentimg > >(tail -n -1) &)
wait $!

echo $imguri
#remove screenshoot after uploding to give more disk space
if [ $? == 0 ]; then
	rm "$IMGURDIR"/"$recentimg"

	if [[ $imguri =~ $m ]]; then
		match="${BASH_REMATCH[1]}"
		echo "$match - $recentimg" >> $LISTUPLOADED
		echo "$match" | xclip -selection clipboard 
	fi
	notify-send "screenshot has been sent to imgur"
fi
