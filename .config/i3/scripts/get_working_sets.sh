#!/bin/bash

defaults=`cat ~/.config/i3/scripts/.default_working_sets`
from_workspaces=`i3-msg -t get_workspaces | jq -r '.[].name' | cut -d ':' -f 1 -s`
all="${defaults}\n${from_workspaces}"

echo -e "${all}" | sort | uniq
