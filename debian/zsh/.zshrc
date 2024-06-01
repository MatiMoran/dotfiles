#------------------------------
# Oh My Zsh 
#------------------------------
ZSH_THEME="matias"

plugins=(
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

autoload -Uz compinit promptinit
compinit
promptinit

#------------------------------
# Exports 
#------------------------------
#export PATH="$PATH:$HOME/.dotnet/tools"
#export PATH="$PATH:/usr/local/go/bin"
#export PATH="$PATH:/opt/mssql-tools18/bin"
#export PATH="$PATH:$HOME/.local/bin"
#export DOTNET_ROOT=/usr/share/dotnet
#export GOPATH="$HOME/go"
export XDG_CONFIG_HOME=$HOME/.config
export REPOS="$HOME $HOME/database/Personal/ $HOME/database/UBA $HOME/.local" 

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
# Alias 
#------------------------------
alias find='fdfind'
alias grep='rg'
alias vim='nvim'

alias ll='ls -hlF --group-directories-first'
alias lla='ls -ahlF --group-directories-first'
alias free='free -m'
alias ..="cd .."
alias cp="cp -i"
alias mkdir="mkdir -pv"

#------------------------------
# Completion 
#------------------------------

#------------------------------
# Keybindings
#------------------------------

# enable vim mode
bindkey -v
bindkey -s '^f' 'source $HOME/.local/scripts/directory-fzf\n'

#------------------------------
# FZF
#------------------------------
source $XDG_CONFIG_HOME/zsh/fzf/completion.zsh
source $XDG_CONFIG_HOME/zsh/fzf/key-bindings.zsh

#------------------------------
# Custom Functions
#------------------------------

### ARCHIVE EXTRACTION
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

### OPEN FILE IN BACKGROUND DETACH FOR THE CURRENT SHELL
# usage: opend <file>
opend() {
  if [ -f "$1" ] ; then
    nohup open "$1" > /dev/null 2>&1 &
  else
    echo "'$1' is not a valid file"
  fi
}

