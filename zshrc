[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Exports
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Paths
export PATH=$PATH:~/.bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node_modules

# Antigen
source $DOTFILES/antigenrc

# Aliases
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -alh -G'
alias ls="command ls -G"
alias ip="ipconfig getifaddr en1"
alias showhidden='defaults write com.apple.finder AppleShowAllFiles true; killall Finder;'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles false; killall Finder;'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
