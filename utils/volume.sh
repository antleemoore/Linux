a=$(pactl list sinks short | grep RUNNING | awk '{print $1}')

if [[ $1 == "up" ]]; then
    pactl -- set-sink-volume $a +2%
elif [[ $1 == "down" ]]; then
    pactl -- set-sink-volume $a -2%
else
    pactl -- set-sink-mute $a toggle
fi
