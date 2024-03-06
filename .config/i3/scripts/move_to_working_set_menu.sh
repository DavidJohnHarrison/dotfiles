#!/bin/bash

RESULT=`~/.config/i3/scripts/get_working_sets.sh | rofi -dmenu -i -p 'Move to Working Set'`
if [ -n "$RESULT" ]; then
    if [ "$RESULT" == "General" ]; then
        RESULT=""
    fi
    ~/.config/i3/scripts/move_to_working_set.sh "${RESULT}"
fi
