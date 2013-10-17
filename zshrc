# Autocompletion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt extendedglob
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*' menu select=2
setopt magicequalsubst # complete dd if=<tab>

[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"
zmodload  zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;34' 
zstyle ':completion:*:processes' command 'ps -au$USER'

# setopt no_nomatch # Avoid "no match found" becomes annoying
alias find='noglob find' # Avoid nomatch found on find

# ZSH highlighting
source /home/antoine/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[path]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta,bold'

setopt printexitvalue
unsetopt listambiguous
# setopt correctall # Correct typo, becomes annoying

zmodload zsh/terminfo

export EDITOR="vimx"
export PAGER="most"
export GIT_PAGER="less"
export VISUAL="vimx"

export PATH="${PATH}:${HOME}/.customcommands/"

#############
# VIM MODE
#############

set -o vi
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line


function zle-line-init zle-keymap-select {
    RPS1="%B${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}%b"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

source ~/.zshrc_bepo_remap

# VCS info
setopt prompt_subst
autoload -Uz vcs_info
#zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats       ' %F{green}%s%f:%F{blue}%b%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

precmd() {
    vcs_info
}

PROMPT=$'[%n@%m %~${vcs_info_msg_0_}]$ '

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Custom aliases
source ~/.zshrc_aliases
# Homemade functions
source ~/.zshrc_functions
