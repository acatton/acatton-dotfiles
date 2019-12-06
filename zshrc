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
source ~/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[path]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta,bold'

setopt printexitvalue
unsetopt listambiguous
# setopt correctall # Correct typo, becomes annoying

zmodload zsh/terminfo

export EDITOR="vimx"
export PAGER="most"
export VISUAL="vimx"

# Avoid having global files telling me where binaries are
PATH="/usr/lib64/ccache:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
export PATH="${PATH}:${HOME}/.customcommands/:${HOME}/.bin/:${HOME}/.local/bin"

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

PROMPT=$'[%n@%m %(5~|%-1~/…/%3~|%~)${vcs_info_msg_0_}]$ '

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# cd history
DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups
## This reverts the +/- operators.
setopt pushdminus

# No duplicate line in the history
setopt HIST_IGNORE_DUPS

# Custom aliases
source ~/.zshrc_aliases
# Homemade functions
for i in ~/.zshrc_functions/*; source $i

WERKZEUG_DEBUG_PIN=off

export PYTHONSTARTUP=~/.pystartup

# fzf completion
FZF_DEFAULT_OPTS='--color=bw'
source ~/.zsh/fzf-key-bindings.zsh
