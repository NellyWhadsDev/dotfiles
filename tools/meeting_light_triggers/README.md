## Requirements
* Install and setup [busylight](https://github.com/JnyJny/busylight)
* Install `jq` and `incron`

## Installation
* Subscribe to audio using `pactl`
``` bash
pactl subscribe | grep --line-buffered "source-output" | xargs -n1 $HOME/Repos/dotfiles/tools/meeting_light_triggers/echo_meeting_status.sh
```
* Subscribe to video using `incron`: `incrontab -e`, add line, save
``` bash
/dev/video* IN_OPEN,IN_CLOSE,IN_CLOSE_WRITE,IN_CLOSE_NOWRITE $HOME/Repos/dotfiles/tools/meeting_light_triggers/echo_meeting_status.sh
```
* Install systemd services
``` bash
cp $HOME/Repos/dotfiles/tools/meeting_light_triggers/*.service $HOME/.config/systemd/user
systemctl daemon-reload --user
systemctl enable mic_watch.service --user
```

## Testing
* Check service status
``` bash
systemctl status mic_watch.service --user
systemctl status busyserve.service --user
```
* Launch Zoom meeting to see if light turns on

## Inspiration
https://hansenji.medium.com/linux-triggers-for-in-meeting-indicator-ea06cdbe41bd