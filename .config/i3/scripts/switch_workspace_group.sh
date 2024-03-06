#!/bin/sh
echo $1 > ~/.config/i3/scripts/.current_workspace_group
workspace=`cat ~/.config/i3/scripts/.current_workspace`

set=`cat ~/.config/i3/scripts/.current_working_set`
if [ -n "${set}" ]; then
    echo "SET NOT NULL"
    set="${set}:"
fi

i3-msg workspace "${set}${1}_${workspace}"
