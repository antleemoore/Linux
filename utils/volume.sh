hdmi=$(pactl list sinks short | grep hdmi | grep RUNNING | awk '{print $1}')
headphones=$(pactl list sinks short | grep analog-stereo | grep RUNNING | awk '{print $1}')

if [[ $1 == "up" ]]; then
    pactl -- set-sink-volume $hdmi +2% ||\
        pactl -- set-sink-volume $headphones +2%
elif [[ $1 == "down" ]]; then
    pactl -- set-sink-volume $hdmi -2% ||\
        pactl -- set-sink-volume $headphones -2%
else
    pactl -- set-sink-mute $hdmi toggle ||\
        pactl -- set-sink-mute $headphones toggle
fi
