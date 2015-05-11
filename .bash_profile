export CLICOLOR=1
export LOGINSPECT_HOME=/Users/dg/Documents/logpoint/ptf/disk
alias ll='ls -alh'
alias la='ls -A'
alias lk='ls -lhSr'
alias l='ls -CFlh'
alias lsd="ls -alhSrF | grep /$"
alias ld='ls -ltr'
alias latest="ls -lrt | tail -1 | awk '{print $NF}'"
alias cd..='cd ..'
alias ..='cd ..'
alias h="history|grep "
alias f="find . |grep "
alias p="ps aux |grep "
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias grep='grep --color=auto'
alias diff='colordiff'
alias binstall="sudo brew install"
alias pinstall="sudo pip install"
alias pversion="pip freeze | grep"
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"
alias envdo="sudo /opt/immune/bin/envdo"
export COCOS2DX_ROOT=/Users/dg/Documents/acstudios/backup/cocos2d-x-2.2.1
export NDK_ROOT=/Users/dg/Documents/acstudios/backup/android-ndk-r10d
export ANDROID_HOME=/Users/dg/Documents/acstudios/backup/adt-bundle-mac-x86_64-20140702/sdk
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="/usr/local/git/bin:$PATH"
export PATH="~/.rvm/bin:$PATH"
export PATH="~/Documents/acstudios/apps/sonar/sonar-runner-2.4/bin:$PATH"
export SONAR_RUNNER_HOME="/Users/dg/Documents/acstudios/apps/sonar/sonar-runner-2.4"
export PATH="/Users/dg/Downloads/python-idzip/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v1.6)
export M2_HOME=~/Downloads/apache-maven-3.2.5
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
#alias refresh_profile=source ~/.bash_profile

patro(){
#can='\[\e[0;31m\]'
#echo -e ""
#echo -ne "Today is "; date
echo -e ""; cal | grep -C6 --color -e " $(date +%e)" -e "^(date +%e)";
#echo -ne "Up time:";uptime | awk /'up/'
#echo "";
}
patro
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

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/dg/Documents/acstudios/backup/cocos2d-x-3.4/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Users/dg/Documents/acstudios/backup/cocos2d-x-3.4/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/Users/dg/Documents/acstudios/backup/adt-bundle-mac-x86_64-20140702/sdk
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT=/usr/local/Cellar/ant/1.9.4/libexec/bin
export PATH=$ANT_ROOT:$PATH

