if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U colors && colors
export IN_API_KEY="896b753cc94a49b3bc84570c92062822"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export ZSH="$HOME/.oh-my-zsh"
export HDD="/run/media/anthony/Internal HDD"
export SSD="/run/media/anthony/Windows SSD"

ZSH_THEME="agnoster"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export BROWSER="firefox"
export HISTCONTROL=ignoredups:erasedups
export EDITOR="nvim"
function cd {
    builtin cd "$@" && lsd && gss 2>/dev/null
}

# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

# To differentiate aliases from other command types
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[globbing]='none'

source $HOME/.zshaliases
source $HOME/.zshprompt
source $HOME/.sfdxalias

neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/anthony/projects/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/anthony/projects/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/anthony/projects/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/anthony/projects/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

