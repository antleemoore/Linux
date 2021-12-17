#!/bin/sh

DMEDITOR="neovide"

declare -a options=(
"alacritty - $HOME/repos/Linux/config/alacritty.yml"
"dunst - $HOME/repos/Linux/config/dunstrc"
"nvim - $HOME/repos/Linux/config/init.vim"
"snippets_nvim - $HOME/repos/Linux/config/.snippets"
"plugins_nvim - $HOME/repos/Linux/config/plugin-config.vim"
"vim - $HOME/repos/Linux/config/.vimrc"
"remaps_vim - $HOME/repos/Linux/config/.vimremap"
"sets_vim - $HOME/repos/Linux/config/.vimset"
"zsh - $HOME/repos/Linux/config/.zshrc"
"xmobar - $HOME/repos/Linux/config/xmonad/xmobar.hs"
"xmonad $HOME/repos/Linux/config/xmonad/xmonad.hs"
"prompt_zsh - $HOME/repos/Linux/config/.zshprompt"
"profile_zsh - $HOME/repos/Linux/config/.zprofile"
"aliases_zsh - $HOME/repos/Linux/config/.zshaliases"
"aliases_sfdx - $HOME/repos/Linux/config/.sfdxalias"
"compile_auto - $HOME/repos/Linux/utils/auto-compile.sh"
"git_auto - $HOME/repos/Linux/utils/autogit.sh"
"chance_rain - $HOME/repos/Linux/utils/chance-rain.sh"
"check_updates - $HOME/repos/Linux/utils/check-updates.sh"
"fan_speed - $HOME/repos/Linux/utils/fan-speed.sh"
"gpu_usage - $HOME/repos/Linux/utils/gpu-usage.sh"
"killport - $HOME/repos/Linux/utils/killport.sh"
"launch_trayer - $HOME/repos/Linux/utils/launch-trayer.sh"
"rewm - $HOME/repos/Linux/utils/reinstall-wm.sh"
"trayer_padding - $HOME/repos/Linux/utils/trayer-padding-icon.sh"
"wait_internet - $HOME/repos/Linux/utils/wait-for-internet.sh"
"delay_xmobar - $HOME/repos/Linux/utils/xmobar-delayed.sh"
"bookmarks_dmenu - $HOME/repos/Linux/scripts/bookmarksdmenu.sh"
"files_dmenu - $HOME/repos/Linux/scripts/confdmenu.sh"
"boot_windows - $HOME/repos/Linux/scripts/bootintowindows.sh"
"close_sfdx_workspace - $HOME/repos/Linux/scripts/closesalesforceworkspace.sh"
"forecast - $HOME/repos/Linux/scripts/forecast.sh"
"start_sfdx_workspace - $HOME/repos/Linux/scripts/startsalesforceworkspace.sh"
"three_monitors - $HOME/repos/Linux/scripts/threemonitorsetup.sh"
"two_monitors - $HOME/repos/Linux/scripts/twomonitorsetup.sh"
"update_calendar - $HOME/repos/Linux/scripts/updatecalendar.sh"
"newsboat - $HOME/repos/Linux/config/.newsboat/config"
)

choice=$(printf '%s\n' "${options[@]}" | dmenu -sb '#458588' -i -p "Files")

if [[ "$choice" ]]; then
    cfg=$(printf '%s\n' "$choice" | awk '{print $NF}')
    sleep 0.1 && $DMEDITOR "$cfg"
fi
