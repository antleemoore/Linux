#!/bin/sh

DMBROWSER="firefox"

declare -a options=(
"Search - https://www.bing.com"
"Calendar - https://calendar.google.com/calendar/u/0/r?pli=1"
"Canvas - https://webcourses.ucf.edu"
"myUCF - https://my.ucf.edu"
"GitHub - https://www.github.com"
"Reddit - https://www.reddit.com"
"Youtube - https://www.youtube.com"
"Twitch - https://www.twitch.tv"
"Crunchyroll - https://www.crunchyroll.com"
"Funimation - https://www.funimation.com"
"MangaDex - https://www.mangadex.com"
"MAL - https://www.myanimelist.com"
"News - https://apnews.com/hub/ap-top-news?utm_source=apnewsnav&utm_medium=sections"

)

choice=$(printf '%s\n' "${options[@]}" | dmenu -sb '#B16286' -i -p 'Bookmarks')
if [[ "$choice" ]]; then
    cfg=$(printf '%s\n' "$choice" | awk '{print $NF}')
    $DMBROWSER "$cfg"
fi
