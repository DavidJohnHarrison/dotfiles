#!/bin/sh
workspace=`cat ~/.config/i3/scripts/.current_workspace`
group=`cat ~/.config/i3/scripts/.current_workspace_group`
echo $1 > ~/.config/i3/scripts/.current_working_set
set=$1
if [ -n "${set}" ]; then
    set="${set}:"
fi
i3-msg workspace "${set}${group}_${workspace}"
