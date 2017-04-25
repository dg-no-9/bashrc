export CLICOLOR=1
PS1="u@h:\\w "

alias sl='ls'
alias l='ls -l'
alias ll='ls -alh'
alias la='ls -Al' #show hidden files
alias lk='ls -lhSr' #sort by size
alias lx='ls -lXB' #sort by extension
alias lc='ls -lcr' #sort by change time
alias lu='ls -lur' #sort by access time'
alias lr='ls -lR' #recursive ls
alias ld='ls -ltr' #sort by date
alias lsd='ls -alhSrF | grep /$'
alias latest="ls -lrt | tail -5 | awk '{print $NF}'"
alias rm='rm -iv'
alias rmf='rm -rf'
alias cp='cp -iv'
alias mv='mv -iv'
alias lsl='ls -al'
alias lt='ls -alt'
alias o='gnome-open '
alias diff='colordiff'
alias cd..='cd ..'
alias ..='cd ..'
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias grep='grep --color=auto'
alias path='echo -e ${PATH//:/\\n}'
alias topproc='ps auxf | grep dgautam | sort -nr -k 4 | head '
alias ps='ps auxf '
alias gs='git status'
alias gss='gits status'
alias gsu='git status -uno'
alias gco='git commit '
alias ga='git add '
alias gsf='git show --pretty="" --name-only ' #Takes one hash code, shows files affected by that commit
alias gdf='git diff --name-status ' #Takes two hash codes, lists files that are changed in between
alias gdc='git diff --cached'
alias gch='git checkout '
alias killsh="kill -9 $(ps aux | grep dgautam | grep -e process | awk '{ print $2 }')" #process=process name
#alias refresh_profile=source ~/.bash_profile
calender
sl(){
ssh support@192.168.2.$1
}
sr(){
ssh support@10.45.1.$1
}

#Create tar archive of a file or folder
maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
# Create a ZIP archive of a file or folder
makezip() { zip -r "${1%%/}.zip" "$1" ; }

#Get Ip Address
function ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig en1 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

#move directory back by given number
up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}
#move director back by given number
function .. (){
    local arg=${1:-1};
    local dir=""
    while [ $arg -gt 0 ]; do
        dir="../$dir"
        arg=$(($arg - 1));
    done
    cd $dir #>&/dev/null
}

#copy and go to directory
cpg (){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

#move and go to directory
mvg (){
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#extract archives
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

#Extracts a column from a table given by command. takes column index as a argument.
#ls -l | fawk 9 (lists 9th column(file names) from a table given by ls -l
function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

function PWD {
pwd | awk -F\/ '{print $(NF-1),$(NF)}' | sed 's/ /\\//'
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

#export PROMPT_COMMAND="echo -n \[\$(date +%r)\]\ "

#parse_git_branch() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
#}
#export PS1="\u@\h:\[\033[32m\]\W>\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

#GIT Stuffs
# Set config variables first
   GIT_PROMPT_ONLY_IN_REPO=1

   GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

   # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
   GIT_PROMPT_SHOW_UNTRACKED_FILES=no # can be no, normal or all; determines counting of untracked files

  # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

   # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10
   function last_three(){
       pwd |rev| awk -F / '{print $1,$2,$3}' | rev | sed s_\ _/_ | sed s_\ _/_ 
   }
   #GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ \u@\h"    # uncomment for custom prompt start sequence
   #GIT_PROMPT_END=''      # uncomment for custom prompt end sequence

   GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ \u@\h \w"
GIT_PROMPT_END="\n${White}\$(date +%H:%M)${ResetColor} $ "
   # as last entry source the gitprompt script
   # GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
   # GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
   GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
   source ~/.bash-git-prompt/gitprompt.sh
