#!/bin/sh
set -e
# Command to run: wget -L https://raw.githubusercontent.com/antleemoore/Linux/arch/config/startup/rice.sh && sh ./rice.sh
sudo pacman -Syyu vim xorg-server-devel neovim noto-fonts-emoji alsa-lib alsa-plugins alsa-utils python3 zsh xorg-xev xorg-xprop nitrogen picom trayer neofetch lsd npm yarn lxsession xmonad xmonad-contrib xmobar cronie aspell-en libmythes mythes-en languagetool alacritty python-pip make gcc discord adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts fcitx-im fcitx-configtool fcitx-anthy xdotool lxappearance ttf-nerd-fonts-symbols-common playerctl mpv xorg-xkill screenkey steam pacman-contrib ntfs-3g mlocate base-devel terminator newsboat
mkdir ~/repos ~/Projects ~/.config/coc ~/.config/dunst ~/.config/picom ~/.xmonad ~/.config/alacritty ~/.config/nvim
git clone https://github.com/antleemoore/Linux ~/repos/Linux
git clone https://github.com/antleemoore/dmenu ~/repos/dmenu
git clone https://aur.archlinux.org/yay.git ~/repos/yay
cd ~/repos/yay && makepkg -si  && cd ~
git clone https://aur.archlinux.org/snapd.git ~/repos/snapd
cd ~/repos/snapd && makepkg -si  && cd ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/ryanoasis/nerd-fonts --depth=1 ~/repos/nerd-fonts
~/repos/nerd-fonts/install.sh
cd ~/repos/dmenu && sudo make install && cd ~
ln -s ~/repos/Linux/scripts ~
ln -s ~/repos/Linux/utils ~
ln -s ~/repos/Linux/config/.screenlayout ~
ln -s ~/repos/Linux/config/.newsboat ~
ln -s ~/repos/Linux/config/alacritty.yml ~/.config/alacritty
ln -s ~/repos/Linux/config/init.vim ~/.config/nvim
ln -s ~/repos/Linux/config/plugin-config.vim ~/.config/nvim
ln -s ~/repos/Linux/config/.pam_environment ~
ln -s ~/repos/Linux/config/.vimrc ~
ln -s ~/repos/Linux/config/.vimset ~
ln -s ~/repos/Linux/config/.vimremap ~
rm -rf ~/.xmonad
ln -s ~/repos/Linux/config/.xmonad/ ~
ln -s ~/repos/Linux/config/picom.conf ~/.config/picom
ln -s ~/repos/Linux/config/dunstrc ~/.config/dunst
python -m pip install --user --upgrade pynvim
nvim +PluginInstall +qall
cd ~/.vim/bundle/coc.nvim && npm install && cd - 
ln -s ~/repos/Linux/config/ultisnip ~/.config/coc
mkdir -p ~/.vim/pack/mbbill/start
cd ~/.vim/pack/mbbill/start
git clone https://github.com/mbbill/undotree.git
vim -u NONE -c "helptags undotree/doc" -c q
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
rm ~/.zshrc
ln -s ~/repos/Linux/config/.zshrc ~
ln -s ~/repos/Linux/config/.zshaliases ~
ln -s ~/repos/Linux/config/.zshprompt ~
ln -s ~/repos/Linux/config/.sfdxalias ~
git clone https://github.com/uditkarode/libxft-bgra ~/repos/libxft-bgra
cd ~/repos/libxft-bgra
sh ./autogen.sh --sysconfdir=/etc --prefix=/usr --mandir=/usr/share/man
sudo make install && cd ~
yay -S lux pfetch microsoft-edge-stable-bin coinmon
sudo ln -s /var/lib/snapd/snap /snap
sudo lux
xmonad --recompile
