#!/bin/bash

set -u
set -e

DOTFILE_REPO_ROOT='https://github.com/NellyWhadsDev/dotfiles'

# Get system type
unameOut="$(uname -s)"
case "$unameOut" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=MacOS;;
    *)          machine="UNKNOWN:$unameOut";;
esac

# If this is a Linux system, check for Ubuntu vs unknown
if [ "$machine" = "Linux" ]; then
    unameOut="$(uname -v)"
    case "$unameOut" in
        *Ubuntu*)    machine=Ubuntu;;
	    *Microsoft*) machine=Microsoft;;
        *)           machine="UNKNOWN:$unameOut";;
    esac
fi

# If this is a WSL Distro, ask user to override using Ubuntu config
if [ "$machine" = "Microsoft" ]; then
    read -r -p "Assume Ubuntu installation for WSL? [Y/n] " response
    case "$response" in
        [yY][eE][sS]|[yY])  machine=Ubuntu;;
        *)                  ;;
    esac
fi
export MACHINE=$machine

if [ "$MACHINE" = "Ubuntu" ] || [ "$MACHINE" = "MacOS" ]; then
    printf '\e[34m%s\e[0m\n' "Installing on $MACHINE" 1>&2
else
    printf '\e[31;1m%s\e[0m\n' "Unsupported environment: '$MACHINE'" 1>&2
    exit 1
fi

# Get UI type from CLI args
export UI_TYPE=default
if [ "${1-}" = "--headless" ]; then
     printf '\e[34;1m%s\e[0m\n' "Only installing heeadless components..." 1>&2
     export UI_TYPE="headless"
fi

export REPOS_DIR=$HOME/Repos
printf '\e[34m%s\e[0m\n' "Setting up 'Repos' dir @ '$REPOS_DIR'..." 1>&2
mkdir -p $REPOS_DIR

printf '\e[34m%s\e[0m\n' "Setting script permissions..." 1>&2
chmod +x ./*/install.sh

printf '\e[34m%s\e[0m\n' "Installing universal dependancies..." 1>&2
if [ "$MACHINE" = "Ubuntu" ]; then
    apt-get update
    apt-get install curl python3 python3-pip vim -y
elif [ "$MACHINE" = "MacOS" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
    brew install curl python
fi
git config --global user.name "Nelly Whads"
git config --global user.email "nellywhads@gmail.com"


# ZSH setup
(cd zsh ; ./install.sh)

# Tmux setup
(cd tmux ; ./install.sh)

# VSCode setup
(cd vscode ; ./install.sh)

# Google Chrome setup
(cd chrome ; ./install.sh)

printf '\n\e[34;1m%s\e[0m\n\n' "Done setting up OS tools" 1>&2
exit 0
