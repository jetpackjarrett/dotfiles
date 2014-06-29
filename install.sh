export HOMEBREW_CASK_OPTS="--appdir=/Applications"

echo 'Installing homebrew...'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'Installing git...'
brew install git

echo 'Setting shell to zsh...'
chsh -s $(which zsh)

echo 'Cloning dotfiles...'
git clone https://github.com/jetpackjarrett/dotfiles.git ~/.dotfiles

echo 'Adding color scheme to iTerm...'
open iterm.itermcolors

echo 'Installing prezto...'
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
zsh ~/.zprezto/init.zsh

echo 'Linking dotfiles...'
sh $HOME/.dotfiles/setup/dotfiles.sh

# echo 'Setting OS defaults...'
# sh $HOME/.dotfiles/setup/osx.sh

echo 'Running Brewfile...'
cd ~/.dotfiles
brew tap Homebrew/bundle
brew bundle

# echo 'Installing apps from App Store...'
# sh app_store_apps.sh

echo 'Wiping dock...'
dockutil --remove all
