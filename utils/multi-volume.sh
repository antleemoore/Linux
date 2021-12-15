b=$(pactl list sinks short | grep hdmi | awk '{print $1}')
a=$(pactl -- get-sink-volume $b)

d=$(pactl list sinks short | grep analog | awk '{print $1}')
e=$(pactl -- get-sink-volume $d)

c=$([[ $a =~ [0123456789]+% ]] && echo "$BASH_REMATCH")
f=$([[ $e =~ [0123456789]+% ]] && echo "$BASH_REMATCH")

echo $1 $f $2 $c
