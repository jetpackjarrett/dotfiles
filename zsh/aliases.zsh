# Shell
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -al -G'
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

# Editor of choice
alias e="$EDITOR"

# iOS simulator
alias ios="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
