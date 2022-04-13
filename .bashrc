# X11 Environment
#export DISPLAY=":0.0"
#location: /home/raccoon/.bashrc or ~/.bashrc

#Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# umask 002
# PROMPT

DEFAULT="\[\e[0;39m\]"
function EXT_COLOR () { echo -ne "\[\033[38;5;$1m\]"; }

##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################
bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=30
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    case $TERM in
     xterm*|rxvt*)
         local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
          ;;
     *)
         local TITLEBAR=""
          ;;
    esac

PS1="`EXT_COLOR 45`\u`EXT_COLOR 15` @ `EXT_COLOR 105`\h`EXT_COLOR 15` [\${NEW_PWD}] ${DEFAULT}$ "
#PS1="[\u@\h \${NEW_PWD}]\\$ "
}

#PS1='[\h:\w] \u% '
#PS1='[\[\e[0;31m\]\h\[\e[0;39m\]:\[\e[0;34m\]\w\[\e[0;39m\]] \u% '
#PS1="\[\033[27m\]\u\033[32m\]@\033[37m\]\H\[\033[1;32m\]:\[\033[34m\] \w\[\033[m\]\[\033[33m\] #>\[\03>


# set color
#set show-all-if-ambiguous On

# ^D won't logout...
set -o ignoreeof

# Report the status of terminated background jobs
# immediately, rather than before the next primary prompt.
set -o notify

# Don't overwrite files when using >
set -o noclobber

#Colorized LS
CLICOLOR=1
#export LSCOLORS=dxfxcxdxbxegedabagacad

alias ls='ls -FG'
alias ll='ls -l'
alias la='ls -a'

alias x=exit

#Initializes the prompt
PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt
