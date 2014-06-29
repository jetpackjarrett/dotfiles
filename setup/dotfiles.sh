DOTFILES_ROOT="$HOME/.dotfiles"

for sym in profile vimrc zshrc zpreztorc gitconfig bin git atom
do
  src="$DOTFILES_ROOT/$sym"
  dst="$HOME/.$sym"
  rm -rf $dst
  echo " $src ---> $dst"
  ln -sf $src $dst
done

# Symlink prezto theme
ln -sf $DOTFILES_ROOT/jarrett.zsh ~/.zprezto/modules/prompt/functions/prompt_jarrett_setup
