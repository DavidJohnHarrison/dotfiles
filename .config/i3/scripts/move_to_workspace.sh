#!/bin/sh
group=`cat ~/.config/i3/scripts/.current_workspace_group`

set=`cat ~/.config/i3/scripts/.current_working_set`
if [ -n "${set}" ]; then
    echo "SET NOT NULL"
    set="${set}:"
fi

i3-msg move container to workspace "${set}${group}_${1}"
