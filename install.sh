xcode-select -p || exit "XCode must be installed! (use the app store)";

echo "$(tput setaf 2)Checking for Homebrew installation...$(tput sgr 0)"
brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
  echo "$(tput setaf 2)✔︎︎$(tput sgr 0) $(tput setaf 3)Homebrew is installed.$(tput sgr 0)"
else
  echo "$(tput setaf 3)Installing Homebrew. Homebrew requires macOS command lines tools, please install xcode first.$(tput sgr 0)"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "$(tput setaf 2)Installing git from homebrew...$(tput sgr 0)"
brew install git

echo "$(tput setaf 2)Cloning dotfiles...$(tput sgr 0)"
git clone git@github.com:jetpackjarrett/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

echo "$(tput setaf 2)Running setup...$(tput sgr 0)"
echo ' '
sh setup.sh

echo 'Installing apps from Brewfile...'
cd ~/.dotfiles
brew tap Homebrew/bundle
brew bundle

echo 'Configuring iTerm...'
cp ~/iterm.json Library/Application\ Support/iTerm2/DynamicProfiles/Profiles.json
open Dracula.itermcolors

echo 'All done. 🥳'