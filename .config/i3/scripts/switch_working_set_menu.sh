#!/bin/bash

RESULT=`~/.config/i3/scripts/get_working_sets.sh | rofi -dmenu -i -p 'Switch Working Set'`
if [ -n "$RESULT" ]; then
    if [ "$RESULT" == "General" ]; then
        RESULT=""
    fi
    ~/.config/i3/scripts/switch_working_set.sh "${RESULT}"
fi
