DOTFILES="$( cd "$(dirname "$0")" ; pwd -P )"
SYMLINKS="zshrc gitconfig"

echo "$(tput setaf 4)Creating .zshrc.local with dotfile path....$(tput sgr 0)"
echo "DOTFILES=$DOTFILES" > $HOME/.zshrc.local

echo "$(tput setaf 4)Creating symlinks....$(tput sgr 0)"
for symlink in $SYMLINKS
do
    src="$DOTFILES/$symlink"
    sym="$HOME/.$symlink"
    if [ -e "$sym" ]
    then
        echo "$(tput setaf 5)  Removing existing $sym $(tput sgr 0)"
        rm $sym
    fi
    echo "$(tput setaf 5)  $src --> $sym $(tput sgr 0)"
    ln -sf $src $sym
done

echo '$(tput setaf 2)Installing apps from Brewfile...'
cd ~/.dotfiles
brew tap Homebrew/bundle
brew bundle

echo 'Creating screenshots directory at ~/Screenshots'
mkdir ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

echo '$(tput setaf 2)Configuring iTerm...'
cp iterm.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/Profiles.json
open Dracula.itermcolors

echo '$(tput setaf 2)All done! 🥳'
