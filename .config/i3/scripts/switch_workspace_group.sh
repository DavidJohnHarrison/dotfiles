#!/bin/sh
echo $1 > ~/.config/i3/scripts/.current_workspace_group
workspace=`cat ~/.config/i3/scripts/.current_workspace`
i3-msg workspace ${1}_${workspace}
