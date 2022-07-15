#!/bin/sh
# Command to run: wget -L https://raw.githubusercontent.com/antleemoore/Linux/arch/config/startup/wsl_rice.sh && sh ./wsl_rice.sh
# upgrade to wsl 2
# install nerd font on windows and enable it in wsl profile
sudo pacman -Syyu git neovim python3 zsh neofetch lsd npm yarn cronie python-pip make gcc pacman-contrib ntfs-3g mlocate base-devel
mkdir ~/repos ~/Projects ~/.config/coc ~/.config/nvim
git clone https://github.com/antleemoore/Linux ~/repos/Linux
git clone https://aur.archlinux.org/yay.git ~/repos/yay
cd ~/repos/yay && makepkg -si  && cd ~
git clone https://aur.archlinux.org/snapd.git ~/repos/snapd
cd ~/repos/snapd && makepkg -si  && cd ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/repos/Linux/scripts ~
ln -s ~/repos/Linux/utils ~
ln -s ~/repos/Linux/config/init.vim ~/.config/nvim
ln -s ~/repos/Linux/config/plugin-config.vim ~/.config/nvim
ln -s ~/repos/Linux/config/.vimrc ~
ln -s ~/repos/Linux/config/.vimset ~
ln -s ~/repos/Linux/config/.vimremap ~
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
yay -S pfetch
sudo ln -s /var/lib/snapd/snap /snap
