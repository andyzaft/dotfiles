# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


source /usr/share/git-core/contrib/completion/git-prompt.sh
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
export HISTFILESIZE=10000
export HISTIGNORE="l;cd .."

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS='-QIMR'

function l4
{
    find . -name '.svn' -prune -o -type f -exec grep --color=auto -i "$1" {} +
}

function l4e
{
    find . -name '.svn' -prune -o -type f -exec egrep --color=auto -i "$1" {} +
}

function l5
{
    ack -i "$1"
}

function title
{
    echo -ne "\033]0;$1\007"
}

function rebaseupstream () {
  branch=prod
  if ! [[ -z "$1" ]]; then
    branch=$1
  fi

  startbranch=$(git describe --contains --all HEAD)
  git checkout $branch
  git fetch upstream
  git fetch upstream --tags
  git rebase upstream/$branch
  git push origin $branch
  git push origin --tags
  git checkout ${startbranch}
}


# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# And after all that I'm going to clobber it with my own prompt

#export PS1="\e[1;36m\u\e[m@\e[1;35m\H\e[m:\e[1;32m\w \e[m \r\n\$ "

# or am I?

if [ "`tput colors`" = "256" ]; then
    BX="\e[0;38;5;67m"
    GX="\e[0;38;5;114m"
    YX="\e[0;38;5;214m"
else
    BX="\e[0;34m"
    GX="\e[0;32m"
    YX="\e[0;33m"
fi
#szinek
bash_prompt_command() {
RET_VAL=$?;
SEMMI='\[\e[0m\]'
PIROS='\[\e[1;31m\]'
ZOLD='\[\e[1;32m\]'
SARGA='\[\e[1;33m\]'
LILA='\[\e[1;35m\]'
KEK='\[\e[1;36m\]'

SSARGA='\[\e[0;33m\]'
SKEK='\[\e[0;34m\]'

if [ $RET_VAL -gt 0 ]; then
    RETC=${PIROS}
else
    RETC=${ZOLD}
fi

RGITPS1=$(__git_ps1 '%s')
if [ ${#RGITPS1} -eq 0 ]; then
    GITSTUFF=""
else
    GITSTUFF="┤${SARGA}\$(__git_ps1 '%s')${SKEK}├──${SEMMI}"
fi

#export PS1='\e[1;36m\u\e[m@\e[1;35m\H\e[m:\e[1;32m\w \e[m $(__git_ps1 " (%s)")\r\n\$ '
#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"
#PS1="┌─(\$newPWD)────────────(\$(date \"+%H:%M\"))───┐\n└─(\u@\h \$)─> "
#PS1="\n${cyan}╔═${WHITE}[${NC}\A${WHITE}]${cyan}═${WHITE}[${NC}\u$(ssh_conn)@${NC}\h${WHITE}]${cyan}═${WHITE}[ ${PWDHILIGHT}\w ${WHITE}]\n${cyan}╚═══${WHITE}[${USRHILIGHT}\$${WHITE}]${NC}> "
#PS1='\[\033[0;32m\]┌┼─┼─ \[\033[0m\033[0;32m\]\u\[\033[0m\] @ \[\033[0;36m\]\h\[\033[0m\033[0;32m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;32m\] ─┤├─ \[\033[0;31m\]\w\[\033[0;32m\] ─┤ \n\[\033[0;32m\]└┼─\[\033[0m\033[0;32m\]\$\[\033[0m\033[0;32m\]─┤▶\[\033[0m\] '
export PS1="${SKEK}┌─┤${KEK}\u${SEMMI}@${LILA}\H${SEMMI}:${ZOLD}\w${SKEK}├──${GITSTUFF}\r\n${SKEK}└┤${SSARGA}\!${SKEK}├${RETC} \$${SEMMI}> "
}
PROMPT_COMMAND=bash_prompt_command

export PATH=${PATH}:~/bin

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'


    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias l='ls -alF --color'
alias ec='emacsclient -n'
#alias ll='ls -l'
#alias la='ls -A'

alias gemins='gem install --no-rdoc --no-ri '

#git
alias gl='git log'
alias ga='git add'
alias gst='git status'
alias gpr='git pull --rebase'
alias grpo='git remote prune origin'

alias gcount='git shortlog -sn'

alias gbr='git branch -a -v'
function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# hub bash completion thing
if [ -f /home/ihorvath/code/hub/etc/hub.bash_completion ]; then
    . /home/ihorvath/code/hub/etc/hub.bash_completion
fi

export CDPATH=.:~:~/code
