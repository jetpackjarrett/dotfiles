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

echo "Configuring Spectacle shotrcuts..."
cp -r spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json 2> /dev/null