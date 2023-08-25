source $HOME/Repos/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle common-aliases
antigen bundle command-not-found
antigen bundle cp
antigen bundle git
antigen bundle debian
antigen bundle thefuck
antigen bundle safe-paste
antigen bundle tmux

antigen theme nellywhadsdev/alien-minimal alien-minimal

antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle Valiev/almostontop
antigen bundle zdharma-continuum/history-search-multi-word@main
antigen bundle lukechilds/zsh-nvm
antigen bundle mattberther/zsh-pyenv
antigen bundle willghatch/zsh-saneopt
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle djui/alias-tips
antigen bundle zdharma-continuum/fast-syntax-highlighting

antigen apply

# Source bash profile if it exists
[[ -f ~/.bash_profile ]] && source ~/.bash_profile

# Show hostname for in theme
export AM_SSH_SYM=$(hostname -s)
export AM_DOCKER_SYM=$(hostname -s) # Docker stores the container ID as hostname

# Disable git stash pager
git config --global pager.stash false
git config --global pager.branch false

# Git worktree aliases
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwac='git worktree add --checkout'
alias gwp='git worktree prune'

# Custom git status alias
alias gwd='git rev-parse --show-toplevel'
alias gst='gw prune ; gw list | grep --color -E "$(gwd).*|$" ; gb ; git status --short ; gstl'

# VSCode Insiders Alias
alias icode='code-insiders'

# Add python/other packages/scripts/tools to path
PATH=$PATH:/usr/local/bin:/home/$USER/.local/bin:/home/$USER/go/bin

# Use python3 by default, only really nevessary on older OS versions
alias pip=pip3
alias python=python3

# Add fuck alias
eval $(thefuck --alias)

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
