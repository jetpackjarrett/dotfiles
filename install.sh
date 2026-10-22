#!/usr/bin/env bash
# Bootstrap a fresh Mac. Safe to re-run.
#
#   bash <(curl -fsSL https://raw.githubusercontent.com/jetpackjarrett/dotfiles/main/install.sh)

set -euo pipefail

REPO="https://github.com/jetpackjarrett/dotfiles.git"
BRANCH="main"
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m  ✓\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m  !\033[0m %s\n' "$*"; }

# ------------------------------------------------- Xcode Command Line Tools ---
if xcode-select -p >/dev/null 2>&1; then
  ok "Xcode Command Line Tools already installed."
else
  info "Installing Xcode Command Line Tools..."
  # This placeholder makes `softwareupdate` list the CLT as an available update.
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  # Handles both the modern "* Label: Command Line Tools for Xcode-x.y" format
  # and the older "* Command Line Tools (macOS ...)" one.
  PROD=$(softwareupdate -l 2>/dev/null \
    | grep -E '^[[:space:]]*\*.*Command Line Tools' \
    | tail -n1 \
    | sed -E 's/^[[:space:]]*\*[[:space:]]*(Label:[[:space:]]*)?//')
  if [[ -n "${PROD:-}" ]]; then
    softwareupdate -i "$PROD" --verbose
  else
    warn "Could not find the CLT in softwareupdate; falling back to the GUI installer."
    xcode-select --install || true
    until xcode-select -p >/dev/null 2>&1; do
      printf '  waiting for Command Line Tools to finish installing...\n'
      /bin/sleep 30
    done
  fi
  rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  ok "Xcode Command Line Tools installed."
fi

# -------------------------------------------------------------- Homebrew ---
if command -v brew >/dev/null 2>&1; then
  ok "Homebrew already installed."
else
  info "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Put brew on PATH for the rest of this script and for future login shells.
for brewpath in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [[ -x "$brewpath" ]] && eval "$("$brewpath" shellenv)" && break
done
BREW_SHELLENV='eval "$(/opt/homebrew/bin/brew shellenv)"'
if ! grep -qF "$BREW_SHELLENV" "$HOME/.zprofile" 2>/dev/null; then
  echo "$BREW_SHELLENV" >>"$HOME/.zprofile"
  ok "Added brew shellenv to ~/.zprofile"
fi

# --------------------------------------------------------------- dotfiles ---
if [[ -d "$DOTFILES/.git" ]]; then
  info "Updating existing dotfiles at $DOTFILES..."
  git -C "$DOTFILES" pull --ff-only
else
  info "Cloning dotfiles to $DOTFILES..."
  git clone --branch "$BRANCH" "$REPO" "$DOTFILES"
fi

# ------------------------------------------------------------------ setup ---
info "Running setup..."
exec "$DOTFILES/setup.sh" "$@"
