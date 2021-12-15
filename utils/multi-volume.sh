a=$(pactl -- get-sink-volume 1)
b=$(pactl -- get-sink-volume 2)

c=$([[ $a =~ [0123456789]+% ]] && echo "$BASH_REMATCH")
d=$([[ $b =~ [0123456789]+% ]] && echo "$BASH_REMATCH")


echo $1 $c $2 $d
