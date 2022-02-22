xcode-select -p || exit "XCode must be installed! (use the app store)";

echo "$(tput setaf 2)Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "$(tput setaf 2)Cloning dotfiles...$(tput sgr 0)"
git clone https://github.com/jetpackjarrett/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

echo "$(tput setaf 2)Running setup...$(tput sgr 0)"
echo ' '
sh setup.sh

