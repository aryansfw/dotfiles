# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Path
export PATH="$PATH:/opt/mssql-tools18/bin"
export PATH="$PATH:$HOME/development/flutter/bin"

# Android
export PATH=$HOME/development/android_sdk/cmdline-tools/latest/bin:$PATH
export PATH=$HOME/development/android_sdk/emulator:$PATH
export PATH=$HOME/development/android_sdk/platform-tools:$PATH
export ADB_SERVER_SOCKET=tcp:$(cat /etc/resolv.conf | grep nameserver | cut -d' ' -f2):5037

# Fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

function find_workspace() {
  if tmux list-sessions &>/dev/null; then
    TMUX_RUNNING=0
  else
    TMUX_RUNNING=1
  fi

  T_RUNTYPE="serverless"
  if [ "$TMUX_RUNNING" -eq 0 ]; then
    if [ "$TMUX" ]; then # inside tmux
      T_RUNTYPE="attached"
    else # outside tmux
      T_RUNTYPE="detached"
    fi
  fi

  NEW_BIND="ctrl-a:reload(fd --type d --hidden . $HOME | sed -e \"s|$HOME/||g\")"
  ZOXIDE_BIND="ctrl-s:reload(zoxide query -l | sed -e \"s|$HOME/||g\")"
  DIRECTORY=$(
    zoxide query -l | sed -e "s|$HOME/||g" | fzf \
    --layout=reverse \
    --border \
    --border-label=" Find Workspace " \
    --margin=1 \
    --info=inline-right \
    --header="omg you're actually gonna start working? ^a all ^s zoxide" \
    --color "border:#ca9ee6,label:#ca9ee6" \
    --bind "$NEW_BIND" \
    --bind "$ZOXIDE_BIND" \
  )

  if [ ! -z $DIRECTORY ]; then
    DIRECTORY=$(echo "$HOME/$DIRECTORY")
    echo $DIRECTORY
    zoxide add "$DIRECTORY" &>/dev/null

    SESSION=$(basename "$DIRECTORY" | tr ' .:' '_')
    tmux new-session -d -A -s "$SESSION" -c "$DIRECTORY"
    case $T_RUNTYPE in # attach to session
      attached)
        tmux switch-client -t "$SESSION"
        ;;
      detached | serverless)
        tmux attach -t "$SESSION"
        ;;
    esac 
  fi
}

function go_to_folder() {
  NEW_BIND="ctrl-a:reload(fd --type d ---hidden . $HOME | sed -e \"s|$HOME/||g\")"
  ZOXIDE_BIND="ctrl-s:reload(zoxide query -l | sed -e \"s|$HOME/||g\")"
  DIRECTORY=$(
    zoxide query -l | sed -e "s|$HOME/||g" | fzf \
    --layout=reverse \
    --border \
    --border-label=" cd " \
    --margin=1 \
    --info=inline-right \
    --header="go to directory. ^a all ^s zoxide" \
    --color "border:#ca9ee6,label:#ca9ee6" \
    --bind "$NEW_BIND" \
    --bind "$ZOXIDE_BIND" \
  )

  if [ ! -z $DIRECTORY ]; then
    DIRECTORY=$(echo "$HOME/$DIRECTORY")
    z $DIRECTORY
  fi
}
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases
alias vim=nvim
alias v="nvim ."
alias w=find_workspace
alias g=go_to_folder
alias cd=z

# Starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init bash)"

# Zoxide
eval "$(zoxide init bash)"
