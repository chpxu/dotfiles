#!/bin/sh
# For each display, changes the wallpaper to a randomly chosen image in
# a given directory at a set interval.

DEFAULT_INTERVAL=300 # In seconds

if [ $# -lt 1 ] || [ ! -d "$1" ]; then
	printf "Usage: %s  DIRECTORY INTERVAL\n" "$0"
	printf "Changes the wallpaper to a randomly chosen image in DIRECTORY every INTERVAL seconds (or every %d seconds if unspecified)." "$DEFAULT_INTERVAL"
	exit 1
fi

# See awww-img(1)
RESIZE_TYPE="crop"
export AWWW_TRANSITION_FPS="${AWWW_TRANSITION_FPS:-30}"
export AWWW_TRANSITION_STEP="${AWWW_TRANSITION_STEP:-2}"

while true; do
	find "$1" -type l \
	| while read -r img; do
		echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
	done \
	| sort -n | cut -d':' -f2- \
	| while read -r img; do
		for d in $(awww query | awk '{print $2}' | sed s/://); do # see awww-query(1)
			# Get next random image for this display, or re-shuffle images
			# and pick again if no more unused images are remaining
			[ -z "$img" ] && if read -r img; then true; else break 2; fi
				#awww img --outputs "$d" "$img"
        awww img --resize "$RESIZE_TYPE" --outputs "$d" "$img"
			unset -v img # Each image should only be used once per loop
		done
		sleep "${2:-$DEFAULT_INTERVAL}"
	done
done
