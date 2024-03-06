#!/bin/sh
echo $1 > ~/.config/i3/scripts/.current_workspace
group=`cat ~/.config/i3/scripts/.current_workspace_group`

set=`cat ~/.config/i3/scripts/.current_working_set`
if [ -n "${set}" ]; then
    echo "SET NOT NULL"
    set="${set}:"
fi

i3-msg workspace "${set}${group}_${1}"
