echo "Installing Homebrew ..."
ruby <(curl -fsS https://raw.githubusercontent.com/Homebrew/homebrew/go/install)

echo "Installing Git..."
brew install git

echo "Generating SSH keys..."
# TODO: Add ssh key gen procedure here

echo "Checking out dotfiles..."
git clone https://github.com/jetpackjarrett/dotfiles.git ~/.dotfiles

echo "Running setup..."
sh ~/.dotfiles/setup.sh
