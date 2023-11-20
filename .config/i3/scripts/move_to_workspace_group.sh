#!/bin/sh
workspace=`cat ~/.config/i3/scripts/.current_workspace`
i3-msg move container to workspace ${1}_${workspace}
