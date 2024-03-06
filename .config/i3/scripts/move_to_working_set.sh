#!/bin/sh
workspace=`cat ~/.config/i3/scripts/.current_workspace`
group=`cat ~/.config/i3/scripts/.current_workspace_group`
set=$1
if [ -n "${set}" ]; then
    set="${set}:"
fi
i3-msg move container to workspace "${set}${group}_${workspace}"
