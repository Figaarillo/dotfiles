#!/usr/bin/env bash

# kill all running
pkill fuzzel &

LAYOUT="$HOME/.config/wlogout/layout"
STYLE="$HOME/.config/wlogout/style.css"
# Clean mode has no blur, so the glass style needs solid surfaces
[ -f /tmp/hypr_cleanmode ] && STYLE="$HOME/.config/wlogout/style-clean.css"

if [[ ! $(pidof wlogout) ]]; then
	wlogout --layout ${LAYOUT} --css ${STYLE} \
		--buttons-per-row 3 \
		--column-spacing 50 \
		--row-spacing 50 \
		--margin-left 300 \
		--margin-right 300
else
	pkill wlogout
fi
