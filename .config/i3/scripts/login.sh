#!/bin/sh

# Key Maps
setxkbmap -option "caps:escape"


# Initial workspace configuration
i3-msg workspace 1:F1_\`
~/.config/i3/scripts/helios/start_helios.sh
