echo 'Installing apps from Brewfile...'
cd ~/.dotfiles
brew tap Homebrew/bundle
brew bundle

echo 'Wiping dock...'
dockutil --remove all