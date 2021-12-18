#!/bin/sh
mkdir ~/repos ~/Projects ~/.config/dunst ~/.config/picom ~/.xmonad ~/.config/alacritty ~/.config/nvim
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
ln -s ~/repos/Linux/config/.zshrc ~
ln -s ~/repos/Linux/config/.zshaliases ~
ln -s ~/repos/Linux/config/.zshprompt ~
ln -s ~/repos/Linux/config/.sfdxalias ~
ln -s ~/repos/Linux/scripts ~
ln -s ~/repos/Linux/utils ~
ln -s ~/repos/Linux/config/.screenlayout ~
ln -s ~/repos/Linux/config/.newsboat ~
ln -s ~/repos/Linux/config/alacritty.yml ~/.config/alacritty
ln -s ~/repos/Linux/config/init.vim ~/.config/nvim
ln -s ~/repos/Linux/config/plugin-config.vim ~/.config/nvim
# ln -s ~/repos/Linux/config/.snippets ~/.config/coc/ultisnip
ln -s ~/repos/Linux/config/.pam_environment ~
ln -s ~/repos/Linux/config/.vimrc ~
ln -s ~/repos/Linux/config/.vimset ~
ln -s ~/repos/Linux/config/.vimremap ~
ln -s ~/repos/Linux/config/xmonad/xmobar.hs ~/.xmonad
ln -s ~/repos/Linux/config/xmonad/xmonad.hs ~/.xmonad
ln -s ~/repos/Linux/config/picom.conf ~/.config/picom
ln -s ~/repos/Linux/config/dunstrc ~/.config/dunst
python -m pip install --user --upgrade pynvim
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
