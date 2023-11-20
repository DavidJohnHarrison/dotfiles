#!/bin/sh
echo $1 > ~/.config/i3/scripts/.current_workspace
group=`cat ~/.config/i3/scripts/.current_workspace_group`
i3-msg workspace ${group}_${1}
