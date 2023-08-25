#!/bin/bash
sleep 10
gfx=$(prime-select query)
if [[ "$gfx" == "intel" ]]; then
tee /proc/axpi/bbswitch <<<OFF
fi
