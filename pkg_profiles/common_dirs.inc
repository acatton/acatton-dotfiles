whitelist ${HOME}/Dev/

# Allow zsh configuration
whitelist ${HOME}/.zshrc
whitelist ${HOME}/.zshrc_aliases
whitelist ${HOME}/.zsh/
whitelist ${HOME}/.zshrc_functions/

# Small scripts
whitelist ${HOME}/.bin
whitelist ${HOME}/.customcommands

# Allow git configuration
whitelist ${HOME}/.gitconfig
whitelist ${HOME}/.gitconfig.d/

# Allow hg configuration
whitelist ${HOME}/.hgrc
whitelist ${HOME}/.hgrc.d/

# Allow vim
whitelist ${HOME}/.vim
whitelist ${HOME}/.vimrc

# Save the history
whitelist ${HOME}/.zsh_history

# Only allow to write to ~/Dev, but do not allow to modify the dofiles.
read-only ${HOME}/
read-write ${HOME}/.zsh_history
read-write ${HOME}/Dev
read-only ${HOME}/Dev/dotfiles/
