#!/bin/sh

declare -a options=(
"vieb"
"microsoft-edge-stable"
"firefox"
)

choice=$(printf '%s\n' "${options[@]}" | dmenu -sb '#ff6188' -i -p 'Bookmarks')
if [[ "$choice" ]]; then
    cfg=$(printf '%s\n' "$choice" | awk '{print $NF}')
    $cfg ""
fi
