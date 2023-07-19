#!/usr/bin/env bash

set -e

PICTURE=~/Pictures/lock.png

insidecolor=00000000
ringcolor=ffffffff
keyhlcolor=d23c3dff
bshlcolor=d23c3dff
separatorcolor=00000000
insidevercolor=00000000
insidewrongcolor=d23c3dff
ringvercolor=ffffffff
ringwrongcolor=ffffffff
verifcolor=ffffffff
timecolor=ffffffff
datecolor=ffffffff
loginbox=00000066
font="sans-serif"
locktext='Type password to unlock...'


cleanup() {
	xset dpms 0 0 0
}

trap cleanup HUP INT TERM EXIT
# Turn off screen after 10 seconds
xset +dpms dpms 0 0 10
# Take screenshot using imagemagick
import -window root /tmp/locking_screen.png

convert -blur 0x8 /tmp/locking_screen.png /tmp/screen_blur.png
convert -composite /tmp/screen_blur.png "$PICTURE" \
				-gravity South \
				-geometry -20x1200 /tmp/screen.png

i3lock-color \
  -t -i '/tmp/screen.png' \
  --time-pos='x+110:h-70' \
  --date-pos='x+43:h-45' \
  --clock --date-align 1 --date-str "$locktext" \
  --inside-color=$insidecolor --ring-color=$ringcolor --line-uses-inside \
  --keyhl-color=$keyhlcolor --bshl-color=$bshlcolor --separator-color=$separatorcolor \
  --insidever-color=$insidevercolor --insidewrong-color=$insidewrongcolor \
  --ringver-color=$ringvercolor --ringwrong-color=$ringwrongcolor --ind-pos='x+280:h-70' \
  --radius=20 --ring-width=4 --verif-text='' --wrong-text='' \
  --verif-color="$verifcolor" --time-color="$timecolor" --date-color="$datecolor" \
  --time-font="$font" --date-font="$font" --layout-font="$font" \
  --verif-font="$font" --wrong-font="$font" \
  --noinput-text='' --force-clock "$lockargs"

cleanup
# Turn the screen off after a delay.
sleep 15
# pgrep i3lock > /dev/null && i3exit suspend
