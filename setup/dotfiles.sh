echo "Installing dotfiles..."

DOTFILES_ROOT=$(dirname "$(dirname $0)")

# echo $DOTFILES_ROOT
# for dir in `ls "$DOTFILES_ROOT/"`
# do
#   src="$DOTFILES_ROOT/$dir"
#   if [ -d "$src" ] && [[ $dir != _* ]]; then
#     echo " $src --->"  "$HOME/.$dir"
#     ln -s $src $HOME/.$dir
#   fi
# done
#
# echo " $DOTFILES_ROOT/zshrc $HOME/.zshrc"
# echo " $DOTFILES_ROOT/profile $HOME/.profile"
# ln -s $DOTFILES_ROOT/zshrc $HOME/.zshrc
# ln -s $DOTFILES_ROOT/profile $HOME/.profile

for sym in profile zshrc gitconfig bin git zsh atom
do
  src="$DOTFILES_ROOT/$sym"
  dst="$HOME/.$sym"
  rm -rf $dst
  echo " $src ---> $dst"
  ln -s $src $dst
done
