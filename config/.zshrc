if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U colors && colors

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export ZSH="$HOME/.oh-my-zsh"

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

source $HOME/.zshaliases
source $HOME/.zshprompt

# colorscript -r
