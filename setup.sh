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
defaults write com.apple.screencapture type -string "jpg"

# echo '$(tput setaf 2)Configuring iTerm...'
# defaults write com.apple.screensaver askForPassword -int 1

# Safari full url
defaults write com.apple.safari "ShowFullURLInSmartSearchField" -bool "false" && killall Safari

echo '$(tput setaf 2)Configuring keyboard...'
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write -g ApplePressAndHoldEnabled -bool false

echo '$(tput setaf 2)Configuring Dock...'
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36
# Clear the dock
defaults write com.apple.dock persistent-apps -array

killall Dock

echo '$(tput setaf 2)Configuring Meubar...'
sudo defaults write com.apple.menuextra.clock DateFormat -string "MMM d h:mm:ss a"
sudo killall SystemUIServer

echo '$(tput setaf 2)Configuring Finder...'
# Set HOME to default finder view
defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
# Keep folder on top
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" && killall Finder
# Set default view to list
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
# Show in finder sidebar
defaults write -g NSTableViewDefaultSizeMode -int 2
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# Show hidden files and file extensions
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles true
# Expand save prompt
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
# Hide desktop icons
defaults write com.apple.finder CreateDesktop -bool false 
killall Finder
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Set Current Folder as Default Search Scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Don't create .DS_Store on external directories
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


echo '$(tput setaf 2)Configuring iTerm...'
cp iterm.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/Profiles.json
open Dracula.itermcolors

echo '$(tput setaf 2)All done! 🥳'
