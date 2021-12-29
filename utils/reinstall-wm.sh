#!/bin/sh
xmonad --recompile
xmonad --restart
# xfce4-panel --restart
killall xmobar
xmobar ~/.xmonad/xmobar.hs &
