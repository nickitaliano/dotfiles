# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


###############################################################################
# Zinit
###############################################################################
################################################
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk################

##############################################################################
# Zsh Parameters
###############################################################################
# Source: http://zsh.sourceforge.net/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
LC_ALL=$LANG # Prefer US English and use UTF-8

# Setting history length
HISTSIZE=999999
SAVEHIST=$HISTSIZE

# Make some commands not show up in history
HISTORY_IGNORE='(l|ls|ll|cd|cd ..|pwd|exit|date|history)'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Get rid of extra empty space on the right.
# See: https://github.com/romkatv/powerlevel10k#extra-space-without-background-on-the-right-side-of-right-prompt
ZLE_RPROMPT_INDENT=0

# Binds Up and Down to a history search, backwards and forwards.
# Source: https://unix.stackexchange.com/a/97844
# zsh-history-substring-search key bindings #############################
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down



###############################################################################
# Zsh Options
###############################################################################
# Source: http://zsh.sourceforge.net/Doc/Release/Options.html

## Changing Directories
# If a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd
unsetopt pushd_ignore_dups
setopt pushdminus
## Completion
setopt complete_in_word
setopt auto_menu
setopt always_to_end
unsetopt flow_control
unsetopt menu_complete
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*:*:kill:*:processes' list-colors'=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors ${(s.:.)LS_COLORS}
# Whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

## Expansion and Globbing
# Make globbing (filename generation) un-sensitive to case.
# Bug: zsh-autosuggestions doesn't respect that parameter: https://github.com/zsh-users/zsh-autosuggestions/issues/239
unsetopt case_glob
# In order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob
# Lets files beginning with a . be matched without explicitly specifying the dot.
setopt glob_dots

## History
# Append history list to the history file; this is the default but we make sure
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
#HISTSIZE=50000
#SAVEHIST=10000

# history config?
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
# because it's required for share_history.
setopt append_history
# Save each command's beginning timestamp and the duration to the history file.
setopt extended_history
# Expire duplicate entries first when trimming history.
setopt hist_expire_dups_first
# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list.
setopt hist_ignore_all_dups
# Remove superfluous blanks before recording entry.
setopt hist_reduce_blanks
# Don't execute immediately upon history expansion.
setopt hist_verify
# Import new commands from the history file also in other zsh-session.
setopt share_history

## Input/Output
# Turns on spelling correction for all arguments.
setopt correct_all
# Turns on interactive comments; comments begin with a #.
setopt interactive_comments

## Job Control
# Display PID when suspending processes as well.
setopt long_list_jobs
# Report the status of backgrounds jobs immediately.
setopt notify

## Shell Emulation
# Use zsh style word splitting.
unsetopt sh_word_split

## Zle
# Avoid beeps and visual bells.
unsetopt beep


# Other
setopt prompt_subst
# setopt prompt_cr
# setopt prompt_cp
unsetopt prompt_cr
#unsetopt prompt_cp


###############################################################################
# Zsh Plugins
###############################################################################
zinit light zsh-users/zsh-completions

# Load custom completion.
fpath=( ~/.zfunc "${fpath[@]}" )

# Initialize completion.
# See: https://github.com/Aloxaf/fzf-tab/issues/61
zpcompinit; zpcdreplay


# Configure fzf and its Zsh integration.
# Source: https://mike.place/2017/fzf-fd/

# Uncomment to set the FZF_DEFAULT_COMMAND
export FZF_DEFAULT_COMMAND="fd --one-file-system --type f --hidden . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --one-file-system --type d --hidden --exclude .git . $HOME"
# Uncomment the following line to disable fuzzy completion
# DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# DISABLE_FZF_KEY_BINDINGS="true"

# https://github.com/junegunn/fzf | brew install fzf #####################
export FZF_BASE="$HOME/.fzf"

# Set fzf installation directory path
export FZF_BASE=/usr/local/opt/fzf/
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zinit light Aloxaf/fzf-tab
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

# Autosuggestion plugin config.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
#ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zinit light zsh-users/zsh-autosuggestions
zinit light darvid/zsh-poetry

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zinit ice depth=1; zinit light romkatv/powerlevel10k


# zplug & oh-my-zsh
# Init zplugexport ZPLUG_HOME=/usr/local/opt/zplug
# Homebrew-installed zplugsource $ZPLUG_HOME/init.zsh# Plugins
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Customize to your needs...
source ~/.zplug/init.zsh
# Plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "clvv/fasd"
zplug "b4b4r07/enhancd"
zplug "junegunn/fzf"
zplug "Peltoche/lsd"
zplug "g-plane/zsh-yarn-autocompletions"
# for zplug: add above the missing plugins check in ~/.zshrc
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
# or
zplug "Powerlevel9k/powerlevel9k", use:powerlevel9k.zsh-theme, from:github, as:theme
# Plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug 'zplug/zplug', hook-build:'zplug --self-manage' #https://github.com/zplug/zplug

# Load zplug
zplug load zsh-history-substring-search
#key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
. /usr/local/etc/profile.d/z.sh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH #dupe
# Crontab
export PATH=/usr/bin:/bin

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX=true
export ZSH="/Users/nickitaliano/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME


# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir
  dir_writable
  custom_python
  virtualenv
  pyenv
  swift_version
  java_version
  vcs
  newline
  status
  ssh
  aws
  docker_machine
  kubecontext
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Create a custom Python/JS/Ruby prompt section
POWERLEVEL9K_CUSTOM_PYTHON="echo -n '\uf81f' Python"
POWERLEVEL9K_CUSTOM_PYTHON_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_PYTHON_BACKGROUND="blue"

# Load Nerd Fonts with Powerlevel9k theme for Zsh
POWERLEVEL9K_MODE="nerdfont-complete"
#source ~/powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  root_indicator
  background_jobs
  status load
)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "sunrise" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"



# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
#export $ZSH="$HOME/plugins/autoupdate"
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=+(
    command-not-found
    git
    z
    fzf
    colored-man-pages
    colorize
    pip
    python
    brew
    osx
    web-search
    node
    tmux
    yarn
    jsontools
    macports
    thor
    thefuck
    iterm2
    history-substring-search-down
    zsh-syntax-highlighting
    zsh-autosuggestions
    alias-finder
    brew
    common-aliases
    copydir
    copyfile
    docker
    docker-compose
    dotenv
    encode64
    extract
    jira
    npm
    npx
    urltools
    vi-mode
    autoupdate
    blackbox
    git-flow-completion
    zsh-completions
    k
    enhancd
    git-secret
    sysadmin-util
    histdb
    nvm
)
#asdf..

#  Git and Common Alias
ZSH_ALIAS_FINDER_AUTOMATIC=”true”


# zplugin
# http://zdharma.org/zplugin/ | brew install zplugin ####################
source "/Users/nickitaliano/.zinit/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

### End of Zplugin installer's chunk ####################################

zplugin ice blockf;

zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-syntax-highlighting

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"

zplugin ice wait lucid atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

zplugin snippet OMZ::plugins/asdf/asdf.plugin.zsh
zplugin snippet OMZ::plugins/dotenv/dotenv.plugin.zsh
zplugin snippet OMZ::plugins/fzf/fzf.plugin.zsh
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin snippet OMZ::plugins/heroku/heroku.plugin.zsh
zplugin snippet OMZ::plugins/safe-paste/safe-paste.plugin.zsh
zplugin snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh

zplugin ice depth=1; zplugin light romkatv/powerlevel10k



# HSTR configuration | brew install hstr #################################
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# https://gist.github.com/ctechols/ca1035271ad134841284  ################
# autoload -Uz compinit
# if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
#     compinit;
# else
#     compinit -C;
# fi;

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

#brew autocompletion for zsh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  typeset -U fpath #https://github.com/asdf-vm/asdf/issues/344
  autoload -Uz compinit
  compinit
fi

# zsh calculator ;-)
autoload -Uz zcalc

#Loading tetris widget :)
autoload -Uz tetris
zle -N tetris
bindkey '\et' tetris    # <Esc> + t


# https://github.com/sorin-ionescu/prezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

#use bd
autoload -Uz bd


###############################################################################
# Expends global searched path to look for brew-sourced utilities.
###############################################################################
# File where the list of path is cached.
PATH_CACHE="${HOME}/.path-env-cache"

# Force a cache refresh if file doesn't exist or older than 7 days.
# Source: https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-3109177
() {
    setopt extendedglob local_options
    if [[ ! -e ${PATH_CACHE} || -n ${PATH_CACHE}(#qN.md+7) ]]; then
        # Ordered list of path.
        PATH_LIST=(
            /usr/local/sbin
            $(brew --prefix coreutils)/libexec/gnubin
            $(brew --prefix grep)/libexec/gnubin
            $(brew --prefix findutils)/libexec/gnubin
            $(brew --prefix gnu-sed)/libexec/gnubin
            $(brew --prefix gnu-tar)/libexec/gnubin
            $(brew --prefix openssh)/bin
            $(brew --prefix curl)/bin
            $(brew --prefix python)/libexec/bin
        )
        print -rl -- ${PATH_LIST} > ${PATH_CACHE}
    fi
}

# Cache exists and has been refreshed in the last 24 hours: load it.
# Source: https://stackoverflow.com/a/41212803
for line in "${(@f)"$(<${PATH_CACHE})"}"
{
    # Prepend paths. Source: https://stackoverflow.com/a/9352979
    path[1,0]=${line}
}


# Homebrew requires this ################################################
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mozjpeg/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# https://github.com/nvbn/thefuck | brew install thefuck ################
eval $(thefuck --alias)
eval "$(starship init zsh)"

autoload -Uz compinit && compinit
# https://asdf-vm.com/ | brew install asdf --HEAD#####################
#. $(brew --prefix asdf)/asdf.sh

#[ -s "$HOME/.asdf/asdf.zsh" ] && . "$HOME/.asdf/asdf.zsh"
#[ -s "$HOME/.asdf/completions/asdf.bash" ] && . "$HOME/.asdf/completions/asdf.bash"

. $HOME/.asdf/asdf.sh
#. $HOME/.asdf/completions/asdf.bash

# jumparpund https://github.com/rupa/z
#. $HOME/z/z.sh

#homebrew
. /usr/local/etc/profile.d/z.sh

# Set go installation directory path
export GOPATH="/usr/local/Cellar/go/1.15.2"
export PATH=$PATH:$(go env GOPATH)/bin

# Use ASDF version of Python3 ###########################################
#export PATH=$HOME/.asdf/shims/python:$PATH

# zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh


#RVM
eval "$(rbenv init -)"

#PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# Setup virtualenv home
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Tell pyenv-virtualenvwrapper to use pyenv when creating new Python environments
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

# Set the pyenv shims to initialize
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
 eval "$(pyenv virtualenv-init -)"
fi

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true


# alias python=python3
# export PIP_REQUIRE_VIRTUALENV=false
# # export PROJECT_HOME=$HOME/Prospace
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

# if which pyenv > /dev/null 2>&1
# then
#     # Pyenv (will add shims to front of $PATH)
#     eval "$(pyenv init -)"

#     # Ensure commands from virtualenvwrapper are available, no matter which
#     # Python version is active. This is equiv to sourcing virtualenvwrapper.sh
#     pyenv virtualenvwrapper
# fi


#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# NPM log level (silent, error,warn, verbose, silly) ####################
#export npm_config_loglevel=silent


###############################################################################
# Prompt
###############################################################################
# Set user & root prompt
export SUDO_PS1='\[\e[31m\]\u\[\e[37m\]:\[\e[33m\]\w\[\e[31m\]\$\[\033[00m\] '

# Do not let homebrew send stats to Google Analytics.
# See: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md#opting-out
export HOMEBREW_NO_ANALYTICS=1


###############################################################################
# Neovim
###############################################################################
# Make Neovim the default editor
export EDITOR="subl"

alias vim='nvim'
alias vi='nvim'
alias v="nvim"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
################################################################################
# Coloured output, aliases and good defaults.
###############################################################################

alias du='du -csh'
alias df='df -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff="colordiff -ru"
alias dmesg="dmesg --color"
alias ccat='pygmentize -g'

alias top="htop"
alias gr='grep -RIi --no-messages'
alias rg='rg -uuu'
alias g="git"
alias h="history"
alias q='exit'
alias how="howdoi --color"

# function cls {
#     # Source: https://stackoverflow.com/a/2198403
#     osascript -e 'tell application "System Events" to keystroke "k" using command down'
# }
# alias c='cls'

# # Use GRC for additionnal colorization
# GRC=$(which grc)
# if [ -n GRC ]; then
#     alias colourify='$GRC -es --colour=auto'
#     alias as='colourify as'
#     #cvs
#     alias configure='colourify ./configure'
#     alias diff='colourify diff'
#     alias dig='colourify dig'
#     alias g++='colourify g++'
#     alias gas='colourify gas'
#     alias gcc='colourify gcc'
#     alias head='colourify head'
#     alias ifconfig='colourify ifconfig'
#     #irclog
#     alias ld='colourify ld'
#     #ldap
#     #log
#     alias make='colourify make'
#     alias mount='colourify mount'
#     #mtr
#     alias netstat='colourify netstat'
#     alias ping='colourify ping'
#     #proftpd
#     alias ps='colourify ps'
#     alias tail='colourify tail'
#     alias traceroute='colourify traceroute'
#     #wdiff
# fi




# export LESS="-eRX"
# export LESSOPEN='| pygmentize -g %s'
# # Tip from http://sourceforge.net/apps/trac/qlc/wiki/InstallationSubversionLinux#Optionalhelpers
# export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
# export LESS_TERMCAP_me=$(tput sgr0)
# export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export LESS_TERMCAP_ZN=$(tput ssubm)
# export LESS_TERMCAP_ZV=$(tput rsubm)
# export LESS_TERMCAP_ZO=$(tput ssupm)
# export LESS_TERMCAP_ZW=$(tput rsupm)

# # Remove spurious find error messages on access restrictions. Keeps find's
# # output clean, tidy and easier to read.
# # Source: https://apple.stackexchange.com/a/353650
# find() {
#   { LC_ALL=C command find "$@" 3>&2 2>&1 1>&3 | \
#     grep -v -e 'Permission denied' -e 'Operation not permitted' >&3; \
#     [ $? = 1 ]; \
#   } 3>&2 2>&1
# }

# # Default options for fd, a faster find.
# alias fd='fd --one-file-system --hidden'

# # Extract most know archives with one command
# extract () {
#     if [ -f "$1" ]; then
#         case "$1" in
#             *.dmg)   hdiutil mount "$1"                ;;
#             *.tar)   tar -xvf "$1"                     ;;
#             *.zip)   unzip "$1"                        ;;
#             *.ZIP)   unzip "$1"                        ;;
#             *.pax)   pax -r < "$1"                     ;;
#             *.pax.Z) uncompress "$1" --stdout | pax -r ;;
#             *.rar)   unrar x "$1"                      ;;
#             *.7z)    7z x "$1"                         ;;
#             *.xar)   xar -xvf "$1"                     ;;
#             *.pkg)   xar -xvf "$1"                     ;;
#             # Rely on GNU's tar autodetection. List of recognized suffixes:
#             # https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
#             *)       tar -axvf "$1"                    ;;
#         esac
#     else
#         echo "'$1' is not a valid file"
#     fi
# }

# # Opens current directory in apps
# alias f='open -a Finder ./'

# # Replace netstat command on macOS to find ports used by apps
# alias netstat="sudo lsof -i -P"

# # Lock the screen
# alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# # Link pinentry and GPG agent together
# if test -f $HOME/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
#     source $HOME/.gnupg/.gpg-agent-info
#     export GPG_AGENT_INFO
# else
#     eval $(gpg-agent --daemon --write-env-file $HOME/.gnupg/.gpg-agent-info)
# fi

# # Deactivate git-delta diff pager.
# export BAT_PAGER=cat


###############################################################################
# Python
###############################################################################

# Don't let Python produce .pyc or .pyo. Left-overs can produce strange side-effects.
export PYTHONDONTWRITEBYTECODE=true

# Python shell auto-completion and history.
export PYTHONSTARTUP="$HOME/.python_startup.py"

# Display DeprecationWarning
#export PYTHONWARNINGS=d


###############################################################################
# File associations, i.e. suffix aliases
###############################################################################
# Source: https://thorsten-hans.com/5-types-of-zsh-aliases#suffix-aliases

alias -s {py,rst,toml,json}=nvim
alias -s {md,markdown}=MacDown
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm}=iina

# Paste a repository URL in terminal, and have it cloned.
alias -s git="git clone"
############################################################################################################################################################################################################################################################################################################################

# Example aliases
#zsh
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# exa is a modern ls.
export TIME_STYLE="long-iso"
LS_FLAGS="--all --group-directories-first --sort=name"
alias ls="exa ${LS_FLAGS} --across"
alias ll="exa ${LS_FLAGS} --long --group --header --binary --created --modified --git --classify"
alias l="ls"
alias tree="ll --tree"

# Handy aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Python
alias python=python3
alias pip=pip3

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

alias cppcompile=c++ -std=c++11 -stdlib=libc++


# Aliases
alias untar='tar -zxvf'
# Unpack .tar file
alias wget='wget -c'
# Download and resume
alias getpass='openssl rand -base64 20'
# Generate password
alias sha='shasum -a 256'
# Check shasum
alias ping='ping -c 5'
# Limit ping to 5'
alias www='php -S localhost:8000' # Run local web server


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
(( ! ${+functions[p10k]} )) || p10k finalize
### Fix for making Docker plugin work
autoload -U compinit && compinit
###
# Created by `userpath` on 2020-12-02 00:11:33
export PATH="$PATH:/Users/nickitaliano/.local/bin"
