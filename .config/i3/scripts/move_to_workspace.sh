#!/bin/sh
group=`cat ~/.config/i3/scripts/.current_workspace_group`
i3-msg move container to workspace ${group}_${1}
