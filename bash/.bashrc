# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profiles
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi


############################# git-flow ##############################

PATH=$PATH:/opt/gitflow


############################## Vi mode ##############################

set -o vi


######################### Extended globbing #########################

shopt -s extglob


############################## ALIASES ##############################

alias gf='git-flow'
alias gff='gf feature '
alias gfr='gf release '

alias ll='ls -l'

alias mplayer-cp='mplayer -subcp cp1250'


alias cdhm='cd ~/mnt'
alias cdhv='cd ~/.vim'
alias cdht='cd ~/tmp'
alias cdc='cd ~/Config'
alias cdd='cd ~/Downloads'
alias cdp='cd ~/Projects'
alias cdpc='cd ~/Projects/Career'
alias cdpcc='cd ~/Projects/Career/CV/cv.modern'
alias cdph='cd ~/Projects/Homepage'
alias cdpj='cd ~/Projects/Java'
alias cdpl='cd ~/Projects/Lisp'
alias cdpn='cd ~/Projects/Niemirow'
alias cdps='cd ~/Projects/Studies'
alias cdpsa='cd ~/Projects/Studies/ACLS'
alias cdpsn='cd ~/Projects/Studies/NetworkServicesImplementationTools'
alias cdpsr='cd ~/Projects/Studies/Rehab'
alias cdpsrr='cd ~/Projects/Studies/Rehab/rehab'
alias cdpst='cd ~/Projects/Studies/Thesis'
alias cdpsts='cd ~/Projects/Studies/Thesis/solaris-crossbow'
alias cdpstst='cd ~/Projects/Studies/Thesis/solaris-crossbow/tex/thesis'
alias cdv='cd ~/.VirtualBox/'
alias cdvs='cd ~/.VirtualBox/Shared'

alias cde='cd /ext'
alias cded='cd /ext/Documents'
alias cdedc='cd "/ext/Documents/C & C++"'
alias cdedj='cd /ext/Documents/Java'
alias cdedt='cd "/ext/Documents/TeX & LaTeX"'
alias cdem='cd /ext/Music'
alias cdep='cd /ext/Photos'
alias cdet='cd /ext/tmp'

alias cdm='cd /mnt'
alias cdml='cd /mnt/loop'
alias cdmp='cd /mnt/pendrive'
alias cdo='cd /opt'
alias cdt='cd /tmp'

xd()
{
	cd `/usr/bin/xd $*`
}
