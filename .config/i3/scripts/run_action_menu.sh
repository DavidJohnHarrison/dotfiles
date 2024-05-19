#!/bin/bash

SCRIPTS_DIR="${HOME}/.config/i3/scripts/actions"
RESULT=`ls $SCRIPTS_DIR | rofi -dmenu -i -p 'Run Action'`
`${SCRIPTS_DIR}/${RESULT}`
