#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
    kill -9 $(pgrep -f 'bin/polybar') > /dev/null 2>&1

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	if [[ "$style" == "hack" || "$style" == "cuts" ]]; then
		polybar -q top -c "$dir/$style/config.ini" &
		polybar -q bottom -c "$dir/$style/config.ini" &
	elif [[ "$style" == "pwidgets" ]]; then
		bash "$dir"/pwidgets/launch.sh --main
	else
		polybar -q main -c "$dir/$style/config.ini" &
	fi
}

if [[ "$1" == "--forest" ]]; then
	style="forest"
	launch_bar

else
	cat <<- EOF
	Usage : launch.sh --theme

	Available Themes :
	--forest
	EOF
fi
