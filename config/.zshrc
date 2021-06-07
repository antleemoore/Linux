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
[ -f "/mnt/c/'Program Files'/'Mozilla Firefox'/firefox.exe" ] \
    && export BROWSER="/mnt/c/'Program Files'/'Mozilla Firefox'/firefox.exe" \
    || export BROWSER="firefox" 
export HISTCONTROL=ignoredups:erasedups
function cd {
    builtin cd "$@" && ls
}

alias la='ls -alF --color=always | grep -v ^l'
alias cdp="cd ~/projects"
alias cdc="cd ~/.config"
alias cds="cd ~/scripts"
alias cdu="cd ~/utils"
alias cdr="cd ~/repos"
alias cdlr="cd ~/repos/Linux"
alias codehere="code . && exit"
alias zshc="vim ~/.zshrc"
alias vimc="vim ~/.vimrc"
alias xmoc="vim ~/repos/Linux/config/xmonad/xmonad.hs"
alias zshs="source ~/.zshrc"
alias vimr="$BROWSER www.vimregex.com"
alias agit="~/scripts/autogit"
alias vim="nvim"
alias gs="git status"
alias lgit="cd ~/repos/Linux && agit && cd -"
alias nvimc="vim ~/.config/nvim/init.vim"
alias killport="~/utils/killport"
alias rewm="~/scripts/reinstall-wm"
alias clear="unset NEW_LINE_BEFORE_PROMPT && clear"
alias supac="sudo pacman -S"

# Vim Mode Config
bindkey -v
export KEYTIMEOUT=1

# Git Config
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
 
setopt PROMPT_SUBST
THEME_PROMPT_PREFIX=${THEME_PROMPT_PREFIX:-''}
THEME_VI_INS_MODE_SYMBOL=${THEME_VI_INS_MODE_SYMBOL:-'λ'}
THEME_VI_CMD_MODE_SYMBOL=${THEME_VI_CMD_MODE_SYMBOL:-'ᐅ'}
THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
zle-keymap-select() {
  if [ "${KEYMAP}" = 'vicmd' ]; then
    THEME_VI_MODE_SYMBOL="${THEME_VI_CMD_MODE_SYMBOL}"
  else
    THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select
zle-line-finish() {
  THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
}
zle -N zle-line-finish
TRAPINT() {
  THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
  return $(( 128 + $1 ))
}
PROMPT='%{$fg[yellow]%}${vcs_info_msg_0_}$THEME_PROMPT_PREFIX%f%B%F{255}%~%f%b 
%(?.%F{cyan}$THEME_VI_MODE_SYMBOL.%F{red}$THEME_VI_MODE_SYMBOL) '
function precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo 
    fi
}
