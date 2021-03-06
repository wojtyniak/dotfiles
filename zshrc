#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

if [ -f ~/.zshrc-local ]; then
  source ~/.zshrc-local
fi
	if type brew &>/dev/null; then
  		FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
	fi

autoload -U compinit
compinit -i

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
setopt APPEND_HISTORY
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# Don't save commands starting with space in history
setopt histignorespace

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors
colors

autoload -U promptinit
promptinit
prompt off
prompt bart

### from toaster
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd notify

# emacs keybindings
bindkey -e

# Don't put duplicates in history
setopt HIST_IGNORE_DUPS

# Pushd by default
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
#setopt pushdminus

## Word-delete should stop on / char
autoload -U select-word-style
select-word-style bash

### Report time for every command that takes more than 3s
REPORTTIME=3

## OS X specific options ##

case `uname` in
    FreeBSD)
        alias ls='ls -FG'
        ;;
    Darwin)
        alias ls='ls -FG'
        ;;
    Linux)
        alias ls='ls -F --color=auto'
        ;;
esac

# ## Ruby
# RBENV_ROOT=/usr/local/var/rbenv # install gems in homebrew directory
# if which rbenv &> /dev/null; then eval "$(rbenv init -)"; fi # autocompletion

## Basic settings
export MANCOLOR=1 # colores!
alias less='less -isR' # R for colors, i for case-agnostic search s for squeezing lines
export FBANDROID_DIR=/Users/wojtyniak/fbsource/fbandroid
alias quicklog_update=/Users/wojtyniak/fbsource/fbandroid/scripts/quicklog/quicklog_update.sh
alias qlu=quicklog_update

# added by setup_fb4a.sh
export ANDROID_SDK=/opt/android/sdk_D9317005
export ANDROID_NDK_REPOSITORY=/opt/android_ndk
export ANDROID_HOME=${ANDROID_SDK}
export PATH=${PATH}:${ANDROID_SDK}/tools:${ANDROID_SDK}/platform-tools
