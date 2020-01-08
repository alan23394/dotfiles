#
# ~/.bashrc
# Alan Barnett
# January 2020
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Starting prompt hello message
echo -ne "\e[1;34mhello \e[m"

# Variables {{{

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="history:ls:pwd:fg:bg:clear:exit"

# For my gcc alias
CFLAGS='-Wall -Wextra -Werror'

# }}}

# Functions {{{

# Make directory, cd into it
function mkcd ()
{
	mkdir -p -- "$@" && cd -- "$@"
}

# Move a file to ~/Trash instead of deleting it
function rm ()
{
	mv -iv -- "$@" ~/Trash
}

# }}}

# Prompt {{{

# Use ptheme for my prompt
. $HOME/bin/ptheme/prompt_alan.sh

# }}}

# Aliases {{{

# default options (add arguments to default commands)
#alias ls='ls --color=auto'			# Add colors
alias ls='ft_ls -cl'				# Use my custom ls instead
alias grep='grep --color=auto'		# Add colors
alias cp='cp -iv'					# Ask before overwriting, show copied files
alias mv='mv -iv'					# Ask before overwriting, show moved files
alias ln='ln -iv'					# Ask before overwriting, show linked files
alias gcc='gcc $CFLAGS'				# CFLAGS defined at the top, in Variables
alias less='/usr/share/nvim/runtime/macros/less.sh'	# Use nvim plugin for less

# shortcut aliases (save typing)
alias la='ls -a'					# -A to ignore . and .. folders
alias ll='ls -l'
alias lla='ls -al'
alias fls='ft_ls -cl'
# TODO make wttr into a script
# take arg for zip code, other args for style of output
# bar vs script vs cli
alias wttr='curl http://wttr.in/94555'
alias gpgpx='gpg -aer gpg@sspx-music.org -r alanbarnett328@gmail.com'
alias btc-graph='curl rate.sx/btc'
alias cn='clear; neofetch'

# git shortcuts
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit --verbose'
alias gC='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --oneline --graph --all'
# Below alias shows full commit hash, which is kinda long
#alias glp='git log --graph --all --patch'
# Below alias shows the short commit hash (oneline), and full commit message
alias glp='git log --oneline --pretty=full --graph --all --patch'
alias gm='git merge'
alias gp='git push'
alias gP='git pull'
alias gr='git reset'
alias gR='git rebase'
alias gs='git status'
alias gS='git stash'

# sudo shortcuts
alias s='sudo systemctl'
alias n='sudo netctl'
alias p='sudo pacman'

# cd shortcuts
alias dots='cd ~/dotfiles'
alias proj='cd ~/projects'

# }}}

# vim: foldmethod=marker foldmarker={{{,}}}
