#!/bin/bash

# busyserve settings
busyserveEnable=0
busyserveHost="0.0.0.0"
busyservePort=8000
busylightColor="red"

# Video
fuser -s /dev/video*
videoOn=$?

# Audio
micOnCondition="media.class = \"Stream/Input/Audio\""
micStandbyCondition="Corked: yes"
audioSources=$(pactl list source-outputs)
delim="
"
string="$audioSources$delim"
# Break audioSources into chunks
array=()
while [[ "$string" ]]; do
  array+=( "${string%%$delim*}"  )
  string="${string#*$delim}"
done
micStandby=1
micOn=1
for i in "${array[@]}"; do
  grep -q "$micOnCondition" <<< "$i"
  if [ $? -eq 0 ]; then
    micOn=0
    grep -q "$micStandbyCondition" <<< "$i"
    if [ $? -eq 0 ]; then
      micStandby=0
    fi
  fi
done

# Status Variables: 0 = Off, 1 = On, 2 = Standby
[ $videoOn -eq 0 ] && camStatus=1 || camStatus=0
if [ $micOn -eq 0 ]; then
  micStatus=1
elif [ $micStandby -eq 0 ]; then
  micStatus=2
else
  micStatus=0
fi

# Echo status
echo "Camera: $camStatus"
echo "Mic: $micStatus"

# If either is in use, turn light on, else turn off
if [ $busyserveEnable -eq 0 ]; then
    if [ $micStatus -eq 0 ] && [ $camStatus -eq 0 ]; then
    curl -s "http://$busyserveHost:$busyservePort/lights/off" | jq
    else
    curl -s "http://$busyserveHost:$busyservePort/lights/on?color=$busylightColor" | jq
    fi
fi