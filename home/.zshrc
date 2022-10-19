# History file
HISTFILE=~/.histfile

HISTSIZE=1200000
SAVEHIST=1000000

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Vim-like command editing
bindkey -v

# Default editor
export EDITOR="vim"

# Edit line in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

# Auto completion
zstyle :compinstall filename "~/.zshrc"

# Autocd
setopt autocd

# Enable colors
autoload -U colors && colors

# Alt-S for sudo in the beginning of the line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Plugins
source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/hist/zsh-hist.plugin.zsh
source ~/.zsh/zsh-lazyload/zsh-lazyload.zsh

# virtualenvwrapper
lazyload workon mkvirtualenv rmvirtualenv -- "source /usr/share/virtualenvwrapper/virtualenvwrapper.sh"

# Other configs
source ~/.zsh/autocompletion.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/aliases.zsh

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

# Substring search
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# Push lines to history
bindkey '^[n' push-line
bindkey '^[r' get-line

# Do not kill background jobs when closing the terminal
setopt NO_HUP

# Load autocompletion
autoload -Uz compinit -C && compinit -C
