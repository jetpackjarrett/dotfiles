#!/bin/zsh
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  echo "Command Line Tools for Xcode not found. Installing from softwareupdate..."
# This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
  softwareupdate -i "$PROD" --verbose;
else
  echo "Command Line Tools for Xcode have been installed."
fi
echo ""

which -s brew
if [[ $? != 0 ]] ; then
  echo "$(tput setaf 2)Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "$(tput setaf 2)Homebrew already installed."
fi

echo "$(tput setaf 2)Cloning dotfiles...$(tput sgr 0)"
git clone https://github.com/jetpackjarrett/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

echo "$(tput setaf 2)Running setup...$(tput sgr 0)"
echo ' '
sh setup.sh



