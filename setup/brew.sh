# Homebrew + Cask + Core Packages installation

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew ..."
    ruby <(curl -fsS https://raw.githubusercontent.com/Homebrew/homebrew/go/install)

  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
    echo "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      export PATH="/usr/local/bin:$PATH"
  fi
else
  echo "Homebrew already installed. Skipping ..."
fi

echo "Updating Formulas..."
brew update

exit 0
