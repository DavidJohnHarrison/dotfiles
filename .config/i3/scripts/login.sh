#!/bin/sh

# Key Maps
setxkbmap -option "caps:escape"


# Initial workspace configuration
echo "F1" > ~/.config/i3/scripts/.current_workspace_group
echo '`' > ~/.config/i3/scripts/.current_workspace
i3-msg workspace F1_\`
#./switch_workspace.sh 1
