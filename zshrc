# Editor
export EDITOR="atom"

# Completion
autoload -U compinit
compinit

# Load sources
for source in ~/.zsh/*
do
  source $source
done

# Auto load colors
autoload -U colors
colors
export CLICOLOR=1

# Enable extended globbing
setopt extendedglob

# rbenv
if which rbenv > /dev/null
then
  eval "$(rbenv init -)"
fi

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
