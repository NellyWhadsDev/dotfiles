#!/bin/bash

pactl subscribe | grep --line-buffered "source-output" | xargs -n1 /home/neil.wadhvana/Repos/dotfiles/tools/meeting_light_triggers/echo_meeting_status.sh