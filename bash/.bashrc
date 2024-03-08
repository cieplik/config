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
addToPath PATH $HOME/.fzf
addToPath PATH ${old_PATH//:/ }

addToPath MANPATH /usr/{,share/}man

addToPath PERL5LIB $HOME/perl5/lib/perl5

export PATH LD_LIBRARY_PATH MANPATH PKG_CONFIG_PATH

set -o vi
export EDITOR=vim

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT='%F %T  '
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend lithist

export PROMPT_COMMAND=__prompt_command

json2table () {
    jq -r '. | (.[0] | keys_unsorted | @tsv),
               (.[]  | map(. // "-") | @tsv)' \
  | column -ts $'\t' "$@"
}

# https://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]; then
    echo "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

function __prompt_command() {
  local RC=$?
  if [ $RC != 0 ]; then
    local STATUS='\[\e[0;31m\]'[$RC]'\[\e[0m\] '
  fi

  PS1="\t ${VIRTUAL_ENV:+(`basename $VIRTUAL_ENV`) }$STATUS\$ "

  log_bash_persistent_history
}

for F in $HOME/.fzf.bash ; do
  [ -r $F ] && . $F
done

# Patch __fzf_history__ to use .persistent_history
eval $(typeset -f __fzf_history__ | sed -re 's@builtin fc [^|]+@; tac ~/.persistent_history | sed -e "s/^/\\t/" @')

# __fzf_history__() {
#   local output opts script
#   opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m --read0"
#   script='BEGIN { getc; $/ = "\n\t"; $HISTCOUNT = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCOUNT - $. . "\t$_" if !$seen{$_}++'
#   output=$(
#     tac ~/.persistent_history |
#       sed -e 's/^/\t/' |
#       last_hist=$(HISTTIMEFORMAT='' builtin history 1) perl -n -l0 -e "$script" |
#       FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) --query "$READLINE_LINE"
#   ) || return
#   READLINE_LINE=${output#*$'\t'}
#   if [[ -z "$READLINE_POINT" ]]; then
#     echo "$READLINE_LINE"
#   else
#     READLINE_POINT=0x7fffffff
#   fi
# }

for F in /usr/share/bash-completion/bash_completion ; do
  [ -r $F ] && . $F && break || true
done
