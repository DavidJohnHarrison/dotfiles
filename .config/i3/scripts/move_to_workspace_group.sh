#!/bin/sh
workspace=`cat ~/.config/i3/scripts/.current_workspace`

set=`cat ~/.config/i3/scripts/.current_working_set`
if [ -n "${set}" ]; then
    set="${set}:"
fi

i3-msg move container to workspace "${set}${1}_${workspace}"
