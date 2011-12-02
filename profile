source ~/.bash_completion.d/git-completion.bash

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
    ack -i -a "$1"
}

function title
{
    echo -ne "\033]0;$1\007"
}

export LESS='-QIMR'
#export BASEDIR=$HOME
export BASEDIR='/Users/ihorvath'
export PROJ_HOME=$BASEDIR'/Projects/6fusion/console/'

if [ -f ~/.bash_aliases ] ; then source ~/.bash_aliases ; fi

alias l='ls -alFG'
alias lh='cd $PROJ_HOME'
alias gemins='gem install --no-rdoc --no-ri '

#git
alias gl='git log'
alias ga='git add'
alias gst='git status'

alias gbr='git branch -a -v'
function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}

#fink
. /sw/bin/init.sh

#szinek
SEMMI='\[\e[0m\]'
ZOLD='\[\e[1;32m\]'
LILA='\[\e[1;35m\]'
KEK='\[\e[1;36m\]'


#export PS1='\e[1;36m\u\e[m@\e[1;35m\H\e[m:\e[1;32m\w \e[m $(__git_ps1 " (%s)")\r\n\$ '
#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"
#PS1="┌─(\$newPWD)────────────(\$(date \"+%H:%M\"))───┐\n└─(\u@\h \$)─> "
#PS1="\n${cyan}╔═${WHITE}[${NC}\A${WHITE}]${cyan}═${WHITE}[${NC}\u$(ssh_conn)@${NC}\h${WHITE}]${cyan}═${WHITE}[ ${PWDHILIGHT}\w ${WHITE}]\n${cyan}╚═══${WHITE}[${USRHILIGHT}\$${WHITE}]${NC}> "
#PS1='\[\033[0;32m\]┌┼─┼─ \[\033[0m\033[0;32m\]\u\[\033[0m\] @ \[\033[0;36m\]\h\[\033[0m\033[0;32m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;32m\] ─┤├─ \[\033[0;31m\]\w\[\033[0;32m\] ─┤ \n\[\033[0;32m\]└┼─\[\033[0m\033[0;32m\]\$\[\033[0m\033[0;32m\]─┤▶\[\033[0m\] '
export PS1="┌─${KEK}\u${SEMMI}@${LILA}\H\e[m:\e[1;32m\w \[\e[1;33m\]\$(__git_ps1)\[\e[m\]\r\n└\[\e[0;33m\][\!]\[\e[0m\] \$ "
