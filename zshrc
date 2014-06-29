# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR="code "
fi

export VISUAL='vim'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Aliases
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -alh -G'
alias ls="command ls -G"

# Ruby
alias be="bundle exec"

# Show hosts file
alias hosts='cat /etc/hosts'

# Get reomte IP address
alias ip="ipconfig getifaddr en1"

# Get local IP address
alias ipr="dig +short myip.opendns.com @resolver1.opendns.com"

# Volume Controls
alias mute="osascript -e 'set volume output muted true'"
alias loud="osascript -e 'set volume 10'"

# Toggle hidden files in Finder
alias showhidden='defaults write com.apple.finder AppleShowAllFiles true; killall Finder;'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles false; killall Finder;'

# Open editor
alias e="$EDITOR"

# iOS simulator
alias ios="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"


# Paths
export NODE_PATH="/usr/local/lib/node"
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node_modules
export ANDROID_HOME=/usr/local/Cellar/android-sdk/24.1.2/
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:~/.bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="$(yarn global bin):$PATH"
#export NVM_DIR=~/.nvm

#source $(brew --prefix nvm)/nvm.sh

autoload -Uz promptinit
promptinit
prompt jarrett

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
