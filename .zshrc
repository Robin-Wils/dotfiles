# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bindkey '^E' end-of-line              # Ctrl-E
bindkey '^[[E' end-of-line            # End
bindkey '^[[P' delete-char            # Delete
bindkey '^[[1;5C' forward-word        # Ctrl-RightArrow
bindkey '^[[1;5D' backward-word       # Ctrl-LeftArrow
bindkey '^[[H' beginning-of-line      # Home
# bindkey '^H' beginning-of-line        # Ctrl-H

# Run SSH agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

# Enable colors
autoload -U colors && colors

# Make it possible to use commands in prompts
setopt prompt_subst
# username@host [git branch] as prompt
PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{yellow}$(git rev-parse --abbrev-ref HEAD 2>/dev/null) %F{blue}%B%~%b%f %# '

# Use historyfile
HISTFILE=~/.cache/zsh/zsh_history

if [ ! -f $HISTFILE ]; then
    mkdir -p ~/.cache/zsh
    touch $HISTFILE
fi

HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Better tab completion
autoload -U compinit
compinit

# No longer need cd to switch dirs
setopt autocd

# Add aliases
if [ -f .zsh_aliases ]; then
    source .zsh_aliases
fi

# Dotfiles tracker
# Function which adds changed dotfiles to git stage
DOTFILES_FILE="/home/rmw/.dotfiles"
if [ ! -f $DOTFILES_FILE ]; then
    touch $DOTFILES_FILE
fi

for dotfile in `cat $DOTFILES_FILE`; do
    git add -f $DOTFILES_FILE/../$dotfile
done
