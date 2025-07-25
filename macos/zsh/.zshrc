#------------------------------
# Exports 
#------------------------------

typeset -U path PATH
path=($path "$HOME/.local/bin")
#path=($path "$HOME/.dotnet/tools")
#path=($path "/usr/local/go/bin")
#path=($path "/opt/mssql-tools18/bin")
export PATH

#export DOTNET_ROOT=/usr/share/dotnet
#export GOPATH="$HOME/go"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export COMMON_DIRS="$HOME $HOME/Repos/Meli" 
export ZSH_PLUGINS="$HOME/.config/zsh/plugins"

#------------------------------
# History 
#------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#------------------------------
# Navigation 
#------------------------------

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt GLOBDOTS

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

export _ZO_DATA_DIR=$XDG_CACHE_HOME
eval "$(zoxide init --cmd cd zsh)"

function fuzzy_open {

    local HOME_DIRS PWD_DIRS DESTINATION

    HOME_DIRS=$(find -H -d 1 . $(echo $COMMON_DIRS))
    
    if [ "$(pwd)" = "$HOME" ]; then
        PWD_DIRS=""
    else
        PWD_DIRS=$(find -H . .)
    fi
    
    DESTINATION=$(echo $HOME_DIRS $PWD_DIRS | fzf --preview "bat --color=always --style=numbers --line-range=:500 {}")
    
    if [ -d "$DESTINATION" ]; then
        cd $DESTINATION
    elif [ -f "$DESTINATION" ]; then
        opend $DESTINATION
    fi

    zle accept-line
}

zle -N fuzzy_open

#------------------------------
# Default Apps 
#------------------------------
export BROWSER="brave"
export EDITOR="nvim"

#------------------------------
# Alias 
#------------------------------
alias find='fd'
alias grep='rg'
alias cat='bat'
alias vim='nvim'

alias ll='ls -hlF --color'
alias lla='ls -ahlF --color'
alias free='free -m'
alias ..="cd .."
alias d='dirs -v'
alias cp="cp -i"
alias mkdir="mkdir -pv"
alias bathelp='bat --plain --language=help'

#------------------------------
# Suggestions
#------------------------------
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=forward-word

source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

#------------------------------
# Completions
#------------------------------
fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)

autoload -Uz compinit; compinit

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu no

source $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:*' continuous-trigger 'tab'

#------------------------------
# FZF
#------------------------------
FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= source <(fzf --zsh)

#------------------------------
# Keybindings
#------------------------------

bindkey -v # enable vim mode
bindkey '^f' fuzzy_open
bindkey '^y' autosuggest-accept
bindkey '^p' forward-word

#------------------------------
# Custom Functions
#------------------------------

### Extract file
# usage: ex <file>
ex () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unar x $1    ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### Open file in background in detached shell
# usage: opend <file>
opend() {
  if [ -f "$1" ] ; then
    nohup open "$1" > /dev/null 2>&1 &
  else
    echo "'$1' is not a valid file"
  fi
}

### Open colorized help
# usage: help <command>
help() {
    "$@" --help | bathelp
}

#------------------------------
# Theme
#------------------------------

autoload -Uz colors; colors
setopt PROMPT_SUBST

ZSH_THEME_GIT_PROMPT_PREFIX="%F{214}git:(%F{226}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{214}) %F{226}%1{✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{214})"

function git_prompt_info {
  local git_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  if [[ -n $git_branch ]]; then
    local git_status=$(git status --porcelain 2>/dev/null)
    local git_dirty=""
    local git_clean=""

    if [[ -n $git_status ]]; then
      git_dirty="${ZSH_THEME_GIT_PROMPT_DIRTY}"
    else
      git_clean="${ZSH_THEME_GIT_PROMPT_CLEAN}"
    fi

    echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${git_branch}${git_dirty}${git_clean}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
  fi
}

PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg_bold[red]%}%~%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'
PROMPT+='$ '

export BAT_THEME="Visual Studio Dark+"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#------------------------------
# Syntax Highlighting
#------------------------------
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#------------------------------
# Starts a new tmux session
#------------------------------
if [ ! -n "$TMUX" ]; then
    tmux new-session -A -s main
fi

export RANGER_FURY_LOCATION=/Users/matmoran/.fury #Added by Fury CLI
export RANGER_FURY_VENV_LOCATION=/Users/matmoran/.fury/fury_venv #Added by Fury CLI

# Added by Fury CLI installation process
declare FURY_BIN_LOCATION="/Users/matmoran/.fury/fury_venv/bin" # Added by Fury CLI installation process
export PATH="$PATH:$FURY_BIN_LOCATION" # Added by Fury CLI installation process
# Added by Fury CLI installation process

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matmoran/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/matmoran/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matmoran/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/matmoran/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
