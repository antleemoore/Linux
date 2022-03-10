#!/bin/sh
mkdir ~/Projects ~/.config/nvim
git clone https://github.com/antleemoore/Linux ~/Downloads/Linux
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/ryanoasis/nerd-fonts --depth=1 ~/Downloads/nerd-fonts
~/Downloads/nerd-fonts/install.sh
cd ~/Downloads/dmenu && sudo make install && cd ~
ln -s ~/Downloads/Linux/config/.zshrc ~
ln -s ~/Downloads/Linux/config/.zshaliases ~
ln -s ~/Downloads/Linux/config/.zshprompt ~
ln -s ~/Downloads/Linux/config/.sfdxalias ~
ln -s ~/Downloads/Linux/scripts ~
ln -s ~/Downloads/Linux/utils ~
ln -s ~/Downloads/Linux/config/init.vim ~/.config/nvim
ln -s ~/Downloads/Linux/config/plugin-config.vim ~/.config/nvim
# ln -s ~/Downloads/Linux/config/ultisnip ~/.config/coc/
ln -s ~/Downloads/Linux/config/.vimrc ~
ln -s ~/Downloads/Linux/config/.vimset ~
ln -s ~/Downloads/Linux/config/.vimremap ~
# python -m pip install --user --upgrade pynvim
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
