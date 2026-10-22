# ~/.zshrc -> $DOTFILES/zshrc
# Machine-specific values (DOTFILES path, work paths, tokens) live in ~/.zshrc.local.

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
: ${DOTFILES:="$HOME/.dotfiles"}

# ---------------------------------------------------------------- homebrew ---
# .zprofile sets this for login shells; repeat it here so non-login shells work.
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  for brewpath in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$brewpath" ]] && eval "$("$brewpath" shellenv)" && break
  done
fi
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_NO_ENV_HINTS=1

# ------------------------------------------------------------------- paths ---
export PATH="$HOME/bin:$HOME/.bin:$DOTFILES/bin:$PATH"

# ----------------------------------------------------------------- plugins ---
# Antidote loads a compiled static plugin file, rebuilt whenever the list changes.
ZSH_PLUGINS_TXT="$DOTFILES/zsh_plugins.txt"
ZSH_PLUGINS_ZSH="${ZDOTDIR:-$HOME}/.zsh_plugins.zsh"
ANTIDOTE_HOME="$(brew --prefix antidote 2>/dev/null)/share/antidote"
if [[ -r "$ANTIDOTE_HOME/antidote.zsh" ]]; then
  source "$ANTIDOTE_HOME/antidote.zsh"
  if [[ ! -r "$ZSH_PLUGINS_ZSH" || "$ZSH_PLUGINS_TXT" -nt "$ZSH_PLUGINS_ZSH" ]]; then
    antidote bundle <"$ZSH_PLUGINS_TXT" >|"$ZSH_PLUGINS_ZSH"
  fi
  source "$ZSH_PLUGINS_ZSH"
fi

# ------------------------------------------------------------------ history ---
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_all_dups hist_ignore_space hist_reduce_blanks
setopt extended_history inc_append_history

# ------------------------------------------------------------------ prompt ---
export STARSHIP_CONFIG="$DOTFILES/starship.toml"
command -v starship >/dev/null && eval "$(starship init zsh)"

# --------------------------------------------------------------- languages ---
# nvm, loaded lazily -- sourcing it eagerly costs ~400ms of shell startup.
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx 2>/dev/null
  [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  [[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]] && \
    source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}
# Put the default nvm node on PATH without sourcing nvm, and fall back to the
# real nvm the first time node/npm/npx is actually invoked.
if [[ -s "$NVM_DIR/alias/default" ]]; then
  nvm_default="$(<"$NVM_DIR/alias/default")"
  [[ -d "$NVM_DIR/versions/node/$nvm_default/bin" ]] \
    && export PATH="$NVM_DIR/versions/node/$nvm_default/bin:$PATH"
  unset nvm_default
fi
for cmd in node npm npx; do
  command -v "$cmd" >/dev/null || eval "$cmd() { nvm use default >/dev/null; $cmd \"\$@\" }"
done
unset cmd

# rbenv
command -v rbenv >/dev/null && eval "$(rbenv init - zsh)"

# Yarn global binaries
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# ---------------------------------------------------------------- fzf / cd ---
command -v fzf >/dev/null && source <(fzf --zsh)
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"

# ----------------------------------------------------------------- aliases ---
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ip='ipconfig getifaddr en0'
alias dotfiles="cd $DOTFILES"
alias reload='exec zsh'
alias showhidden='defaults write com.apple.finder AppleShowAllFiles true; killall Finder'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles false; killall Finder'

if command -v eza >/dev/null; then
  alias ls='eza --group-directories-first'
  alias ll='eza -lah --git --group-directories-first'
  alias lt='eza --tree --level=2 --group-directories-first'
else
  alias ll='ls -alhG'
fi
command -v bat >/dev/null && alias cat='bat --paging=never'
command -v lazygit >/dev/null && alias lg='lazygit'

# Update everything: dotfiles, brew bundle, plugins.
dotup() {
  git -C "$DOTFILES" pull --ff-only \
    && brew update && brew bundle install --file="$DOTFILES/Brewfile" && brew upgrade && brew cleanup \
    && antidote update \
    && exec zsh
}

# ------------------------------------------------------------------- misc ---
export EDITOR="code --wait"
export ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# iTerm2 shell integration
[[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
