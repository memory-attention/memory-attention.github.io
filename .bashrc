# .bashrc
###################################################
# My bash configuration
#--------------------------------------------------
# Seung Seop Park (sspark@hi.snu.ac.kr)
# Human Interface Lab, SNU / Jan 2007
###################################################

set locale
export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8
export LD_LIBRARY_PATH=/usr/lib/nvidia-cuda-toolkit 
#export LC_ALL="C"

#---- set prompt 
BLACK="\[\e[0;30m\]"
BLUE="\[\e[0;34m\]"
GREEN="\[\e[0;32m\]"
CYAN="\[\e[0;36m\]"
RED="\[\e[0;31m\]"
PURPLE="\[\e[0;35m\]"
BROWN="\[\e[0;33m\]"
LIGHT_GRAY="\[\e[0;37m\]"
DARK_GRAY="\[\e[1;30m\]"
LIGHT_BLUE="\[\e[1;34m\]"
LIGHT_GREEN="\[\e[1;32m\]"
LIGHT_CYAN="\[\e[1;36m\]"
LIGHT_RED="\[\e[1;31m\]"
LIGHT_PURPLE="\[\e[1;35m\]"
YELLOW="\[\e[1;33m\]"
WHITE="\[\e[1;37m\]"
NO_COLOR="\[\e[0m\]"
if [ "$UID" -eq 0 ]; then
	PS1="[\u@\h ${RED}\W${NO_COLOR}] "
else
	PS1="[\u@\h ${YELLOW}\W${NO_COLOR}] "
fi
###### End of set Prompt #####


#------------------------------------------------------------------
# Some shell options
#------------------------------------------------------------------
ulimit -S -c 0		# Don't want any coredumps
set -o notify           # print job completion message immediately
set -o noclobber        # force >| to overwrite for existing files -> Prevents accidentally clobbering files.
set -o ignoreeof        # don't exit shell when Ctrl+D 
#set -o nounset          # make it an error to substitute an unset variable
#set -o xtrace           # useful for debuging
shopt -s cdspell        # try to correct minor spelling errors in cd command
shopt -s cdable_vars    # treat an arg to cd that is not a directory as a variable whose value is the directory name
shopt -s checkhash      # check that command in the hash table still exists
shopt -s checkwinsize   # check winsize after each command and update $LINES and $COLUMNS
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist	# multi-line commands appended to history as single-line, for ease of editing
shopt -s histappend histreedit histverify
shopt -s extglob	# necessary for programmable completion
shopt -s dotglob	# includes dotfiles in tab-completion
shopt -s nocaseglob	# case insensitive glob

# I want bash to do vi-like editing ;
#+ and add followings to /etc/inputrc or ~/.inputrc
#+ set editing-mode vi
#+ set keymap vi
#set -o vi    


    
#------------------------------------------------------------------
# Personnal Aliases
#------------------------------------------------------------------
alias fplay="esddsp da +f -s 16"
#alias emacs='emacs -nw'
alias cvtDOS="tr -d '\r' "
alias pd='pushd'
alias pd2='pushd +2'
alias pd3='pushd +3'
alias pd4='pushd +4'
alias setcds='source ~/.cd_aliases'
alias rm='rm -i'
alias rmf='rm -rf'
alias cp='cp -i'
alias mv='mv -i'
#alias a2ps="a2ps -P lp_302dong "
alias mkdir='mkdir -p'
#alias vi='/usr/local/bin/vim'
#alias vi='vi -X'
alias vim='vi'
alias h='history'
alias j='jobs -l'
alias which='type -all'
alias ..='cd ..; ls'
alias ...='cd ../..; ls'
alias ,='cd -; ls'    	# cd to previous
alias path='echo -e ${PATH//:/\\n}'
#alias du='du -kh'
alias du='du -chs'
alias df='df -kTh'
alias ml='matlab -nojvm -nosplash -nodisplay'

#---- rcs
alias ci='ci -u'
alias co='co -l'

#---- 'ls' family 
alias ls='ls -F --color=auto --show-control-chars'	# add colors for filetype recognition
alias l='ls -l -o -F --color=auto'
alias lt='ls -ltr'              # sort by date
alias la='ls -Al'               # show hidden files
alias lr='ls -lR'               # recursive ls
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lhSr'              # sort by size
#alias lc='ls -lcr'		 # sort by change time  
#alias lu='ls -lur'		 # sort by access time   
#alias lm='ls -al |more'         # pipe through 'more'
#alias tree='tree -Csu'		# nice alternative to 'ls'
lsx() { ls -F -o --color "$@" | grep ^-..x ; } # excutables only
lsl() { ls -F -o --color "$@" | grep ^l ; } # symlinks only
lsf() { ls -F -o --color "$@" | grep ^- ; } # files only
lsd() { ls -F -o --color "$@" | grep ^d ; } # dirs only
if [ "$TERM" = dumb ]; then unalias ls; fi



#------------------------------------------------------------------
# Utility functions
#------------------------------------------------------------------
mark()  #---- bookmark directories 
{
    Usage="Usage: mark word"
    case $# in
        1 ) export "$1"=cd `pwd` ;;
        * ) echo "Incorrect Arguments count "
            echo $Usage ;;
    esac
}

goto() 
{
    Usage="Usage: goto word"
    case $# in
        1)  if env | grep "^$1=cd " > /dev/null ; then
                eval \$"$1"
                #echo "New current directory is `pwd`"
            else
                echo $Usage
            fi ;;
        *)  echo "Incorrect Argument count"
            echo  $Usage  ;;
    esac
}

#------------------------------------------------------------------
#---- File & strings related functions:
function fswap()         # swap 2 filenames around
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

# find pattern in a set of files and highlight them:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | \
sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function cuttail() # cut last n lines in file, 10 by default
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

#------------------------------------------------------------------
#---- Process/system related functions:
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }
# This function is roughly the same as 'killall' on linux
# but has no equivalent (that I know of) on Solaris
function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function my_ip() # get IP adresses
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
}

function ii()   # get current host related info
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo
}

#------------------------------------------------------------------
#---- Misc utilities:
function repeat()       # repeat n times command
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

function ask()
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/jylee/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/jylee/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jylee/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/jylee/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/jylee/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/jylee/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jylee/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/jylee/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
