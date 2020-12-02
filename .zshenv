#!/bin/zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

#export TERM='rxvt-256color'
#export DOTFILES="$HOME/.dotfiles"

#[ -f $DOTFILES/install_config ] && source $DOTFILES/install_config

# # XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# # editor
export EDITOR="subl"
export VISUAL="nvim"

# # zsh

# export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# # other software
# #export TMUXP_CONFIGDIR="$XDG_CONFIG_HOME/tmuxp"
# #export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
# #export I3_CONFIG="$XDG_CONFIG_HOME/i3"
# export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
# #export GIMP_VERSION="2.10"

# # X11
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

# # Racket
# #export PLTUSERHOME="$XDG_DATA_HOME"/racket

# # golang
# # export GOPATH="$HOME/workspace/go"
# # export GOBIN="$HOME/workspace/go/bin"
# # export GOCACHE="$XDG_CACHE_HOME/go-build"

# # NPM
# export NPM_PATH="$XDG_CONFIG_HOME/node_modules"
# export NPM_BIN="$XDG_CONFIG_HOME/node_modules/bin"
# export NPM_CONFIG_PREFIX="$XDG_CONFIG_HOME/node_modules"

# # git
# #export GIT_REVIEW_BASE=master # See gitconfig

# # PATH
# #export PATH="$COMPOSER_HOME/vendor/bin:$PATH"                       # COMPOSER
# #export PATH="$GOBIN:$PATH"                                          # GOBIN
# export PATH="$NPM_BIN:$PATH"                                        # NPM