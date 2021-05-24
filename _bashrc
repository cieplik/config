#!/bin/bash

stty -ixon

function addToPath
{
  local P=$1; shift

  for DIR in "$@"; do
    [ -e $DIR ] && [[ :"${!P}": != *:"$DIR":* ]] && eval "$P=${!P:+${!P}:}$DIR"
  done
}

export HIERS=$HOME/hiers

old_PATH=$PATH
PATH=

for F in $HIERS/[!.]*; do
  addToPath PATH            $F/bin
  addToPath LD_LIBRARY_PATH $F/{,usr/}lib{,64}
  addToPath PKG_CONFIG_PATH $F/{,usr/}lib{,64}/pkgconfig
  addToPath MANPATH         $F/{,share/}man
  addToPath ACLOCAL_PATH    $F/share/aclocal
done

addToPath PATH $HOME/go/bin
addToPath PATH ${old_PATH//:/ }

addToPath MANPATH /usr/{,share/}man

export PATH LD_LIBRARY_PATH MANPATH PKG_CONFIG_PATH

set -o vi
export EDITOR=vim

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT='%F %T  '
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend lithist

export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
  local RC=$?
  if [ $RC != 0 ]; then
    local STATUS='\[\e[0;31m\]'[$RC]'\[\e[0m\] '
  fi

  PS1="\t ${VIRTUAL_ENV:+(`basename $VIRTUAL_ENV`) }$STATUS\$ "
}

for F in $HOME/.bashrc.{local,completion} $HOME/.fzf.bash $HOME/.bash_completion.d/python-argcomplete ; do
  [ -r $F ] && . $F
done
