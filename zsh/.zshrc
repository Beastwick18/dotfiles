# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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

# Would you like to use another custom folder than $ZSH/custom
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
)

ZSH_AUTOSUGGEST_STRATEGY=(history completion) 

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fpath=($HOME/repos/zsh-completions/src $fpath)

ZSH_COMPDUMP="$HOME/.cache/zsh/zcompcache"
[[ -d $ZSH_COMPDUMP ]] || mkdir -p $ZSH_COMPDUMP
autoload -U compinit -d "$ZSH_COMPDUMP/zcompdump-$ZSH_VERSION" && compinit -u -d "$ZSH_COMPDUMP/zcompdump-$ZSH_VERSION"

##

# Add git-extras completions
source /usr/share/doc/git-extras/git-extras-completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

export PATH=$HOME/.local/bin:$HOME/.local/bin/dotbin:$PATH:$HOME/go/bin:$HOME/.local/share/cargo/bin
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/startup.py"
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
compinit -d "$ZSH_COMPDUMP/zcompdump-$ZSH_VERSION"

export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker 
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

export GPG_TTY=$(tty)

# gq() {
#     git add --all && git commit -m "`date +'%m-%d-%y %H:%M:%S'`" && git push
# }

export EDITOR="/usr/sbin/nvim"
export MANPAGER='nvim +Man!'

alias nvimc="$EDITOR $HOME/.config/nvim"
alias zshc="$EDITOR $ZDOTDIR/.zshrc"
alias nyaac="$EDITOR $HOME/.config/nyaa/config.toml"
alias hyprc="$EDITOR $HOME/.config/hypr/"
alias panelc="$EDITOR $HOME/.config/hypr/"

alias sudoedit="sudo -E $EDITOR"
alias svim="sudoedit"
alias ls="eza --icons=auto -a --git -1 --group-directories-first"
alias wget="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""
alias g="lazygit"
alias yay="paru"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias cat='bat'
alias config='dot config'
alias icat="kitten icat"

alias d="dot"
alias dp="dot push"
alias dl="dot pull"
alias ds="dot sync"
alias da="dot add"
alias di="dot install"
alias dd="dot diff"
alias dt="dot list"
alias dc="dot cd"

alias todo="bat --plain ~/todo.md"
alias todoc="$EDITOR ~/todo.md"

# Setup zoxide
if command -v zoxide &> /dev/null ; then
    eval "$(zoxide init --cmd cd zsh)"
fi

[[ ! -f "$ZDOTDIR/.local.zsh" ]] || source "$ZDOTDIR/.local.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup=$("$XDG_DATA_HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$XDG_DATA_HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$XDG_DATA_HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$XDG_DATA_HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# bat --plain --color=always ~/todo.md
