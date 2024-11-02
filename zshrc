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
export PAGER="less -R"
export VISUAL="vimx"

# Avoid having global files telling me where binaries are
PATH="/usr/lib64/ccache:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
export PATH="${PATH}:${HOME}/.customcommands/:${HOME}/.bin/:${HOME}/.local/bin"
test "x${CUSTOM_FIREJAIL_PATH}" '!=' "x" && export PATH="${CUSTOM_FIREJAIL_PATH}:${PATH}"

# VCS info
setopt prompt_subst
autoload -Uz vcs_info
#zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats       ' %F{green}%s%f:%F{blue}%b%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

precmd() {
    vcs_info
}

_PROMPT_FIREJAIL_ENV=''
test "x${CUSTOM_FIREJAIL_ENV}" '!=' "x" && _PROMPT_FIREJAIL_ENV="%F{blue}(${CUSTOM_FIREJAIL_ENV})%f"

PROMPT=$'${_PROMPT_FIREJAIL_ENV}[%n@%m %(5~|%-1~/…/%3~|%~)${vcs_info_msg_0_}]$ '

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
# Command history
export HISTFILE=~/.zsh_history
test "x${CUSTOM_FIREJAIL_ENV}" '!=' 'x' && export HISTFILE=~/.pkgs/cache/zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt appendhistory

# Custom aliases
source ~/.zshrc_aliases
# Homemade functions
for i in ~/.zshrc_functions/*; source $i

WERKZEUG_DEBUG_PIN=off

export PYTHONSTARTUP=~/.pystartup

# fzf completion
FZF_DEFAULT_OPTS='--color=bw'

export BAT_THEME=GitHub

setopt PROMPT_SUBST

source ~/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh

source ~/.zsh/fzf-key-bindings.zsh
unset MODE_CURSOR_DEFAULT
MODE_INDICATOR_VIINS='%BINSERT%b '
MODE_INDICATOR_VICMD='%BNORMAL%b '
MODE_INDICATOR_REPLACE='%BREPLACE%b'
MODE_INDICATOR_SEARCH='%BSEARCH%b '
MODE_INDICATOR_VISUAL='%BVISUAL%b '
MODE_INDICATOR_VLINE='%BV-LINE%b '

export CUSTOM_FIREJAIL_PROFILEDIR="/home/antoine/Dev/perso/dotfiles/pkg_profiles"

# Better man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
