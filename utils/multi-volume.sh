#!/bin/sh
hdmiemoji=$2
hdmi=$(pactl list sinks short | grep hdmi | awk '{print $1}')
hdmivolume=$(pactl -- get-sink-volume $hdmi)
hdmimute=$(pactl -- get-sink-mute $hdmi | awk '{print $2}')
if [ "$hdmimute" == "yes" ]; then
    hdmiemoji=$3
fi

hpemoji=$1
hp=$(pactl list sinks short | grep analog-stereo | awk '{print $1}')
hpvolume=$(pactl -- get-sink-volume $hp)
hpmute=$(pactl -- get-sink-mute $hp | awk '{print $2}')
if [ "$hpmute" == "yes" ]; then
    hpemoji=$3
fi

sprint=$([[ $hdmivolume =~ [0123456789]+% ]] && echo "$BASH_REMATCH")
hpprint=$([[ $hpvolume =~ [0123456789]+% ]] && echo "$BASH_REMATCH")

echo $hpemoji $hpprint $hdmiemoji $sprint
