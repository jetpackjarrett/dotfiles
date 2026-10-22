#!/usr/bin/env bash
# Link configs, install packages, apply macOS defaults. Idempotent -- re-run any time.
#
#   ./setup.sh              everything
#   ./setup.sh link         symlinks only
#   ./setup.sh brew         Brewfile only
#   ./setup.sh macos        macOS defaults only

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
export DOTFILES

info() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m  ✓\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m  !\033[0m %s\n' "$*"; }

for brewpath in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [[ -x "$brewpath" ]] && eval "$("$brewpath" shellenv)" && break
done

# "repo/path:$HOME-relative/target"
SYMLINKS=(
  "zshrc:.zshrc"
  "gitconfig:.gitconfig"
  "gitignore_global:.gitignore_global"
  "claude/settings.json:.claude/settings.json"
  "karabiner/karabiner.json:.config/karabiner/karabiner.json"
  "bin/cc-status:.config/iterm2/cc-status"
)

link_all() {
  info "Creating symlinks..."
  for entry in "${SYMLINKS[@]}"; do
    src="$DOTFILES/${entry%%:*}"
    dst="$HOME/${entry##*:}"

    if [[ ! -e "$src" ]]; then
      warn "missing in repo, skipping: ${entry%%:*}"
      continue
    fi
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
      ok "already linked: ${entry##*:}"
      continue
    fi

    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" || -L "$dst" ]]; then
      backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
      mv "$dst" "$backup"
      warn "backed up existing ${entry##*:} -> $(basename "$backup")"
    fi
    ln -s "$src" "$dst"
    ok "${entry##*:} -> ${entry%%:*}"
  done

  # DOTFILES location for the shell, preserving any other local settings.
  touch "$HOME/.zshrc.local"
  # Guarantee a trailing newline so the append below cannot join two lines.
  [[ -s "$HOME/.zshrc.local" && -n "$(tail -c1 "$HOME/.zshrc.local")" ]] \
    && printf '\n' >>"$HOME/.zshrc.local"
  if grep -q '^export DOTFILES=' "$HOME/.zshrc.local"; then
    sed -i '' "s|^export DOTFILES=.*|export DOTFILES=$DOTFILES|" "$HOME/.zshrc.local"
  else
    printf 'export DOTFILES=%s\n' "$DOTFILES" >>"$HOME/.zshrc.local"
  fi
  ok "~/.zshrc.local points at $DOTFILES"

  # Per-machine git identity, created empty so [include] never warns.
  [[ -e "$HOME/.gitconfig.local" ]] || {
    printf '# Per-machine git overrides, e.g.\n# [user]\n#\temail = you@example.com\n' \
      >"$HOME/.gitconfig.local"
    ok "created ~/.gitconfig.local"
  }
}

brew_all() {
  if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew not found -- run install.sh first. Skipping packages."
    return
  fi
  info "Installing packages from Brewfile (this takes a while)..."
  brew update
  # Mac App Store installs need you signed in to the App Store app first.
  brew bundle install --file="$DOTFILES/Brewfile" --no-upgrade || \
    warn "Some Brewfile entries failed. Sign in to the App Store for the 'mas' lines, then re-run: ./setup.sh brew"
  brew cleanup
  ok "Packages installed."

  info "Building the zsh plugin bundle..."
  if [[ -r "$(brew --prefix antidote 2>/dev/null)/share/antidote/antidote.zsh" ]]; then
    zsh -c "source \$(brew --prefix antidote)/share/antidote/antidote.zsh \
            && antidote bundle <'$DOTFILES/zsh_plugins.txt' >| '$HOME/.zsh_plugins.zsh'"
    ok "~/.zsh_plugins.zsh built."
  else
    warn "antidote not installed; the plugin bundle will build on first shell start."
  fi
}

iterm_all() {
  info "Pointing iTerm2 at the tracked preferences..."
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES/iTerm"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
  ok "iTerm2 will load prefs from $DOTFILES/iTerm (restart iTerm2 to pick them up)."
}

macos_all() {
  info "Applying macOS defaults..."
  "$DOTFILES/macos.sh"
}

case "${1:-all}" in
  link)  link_all ;;
  brew)  brew_all ;;
  macos) macos_all ;;
  iterm) iterm_all ;;
  all)   link_all; brew_all; iterm_all; macos_all ;;
  *)     echo "usage: $0 [all|link|brew|macos|iterm]" >&2; exit 2 ;;
esac

info "All done! 🥳"
cat <<'NEXT'

  Still to do by hand:
    - Sign in to the App Store, then re-run `./setup.sh brew` to get the mas apps
    - Restart iTerm2 so it picks up the tracked preferences
    - Set your iTerm2 font to "Hack Nerd Font" for the prompt glyphs
    - Grant Karabiner-Elements input-monitoring permission in System Settings
    - Sign in: 1Password, Dropbox, Raycast, Slack
    - Generate an SSH key and add it to GitHub:
        ssh-keygen -t ed25519 -C "$(whoami)@$(hostname -s)" && gh auth login

NEXT
