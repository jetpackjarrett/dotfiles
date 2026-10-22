# Brewfile -- `brew bundle install` from the repo root.
# Covers everything needed to bring a fresh Mac up to a working machine.

# ------------------------------------------------------------------- taps ---
tap "git-friendly/git-friendly"

# ------------------------------------------------------------------ shell ---
brew "antidote"          # zsh plugin manager
brew "starship"          # prompt
brew "coreutils"         # GNU coreutils (gls, gdate, ...)

# -------------------------------------------------------------------- cli ---
brew "bat"               # cat with syntax highlighting
brew "eza"               # modern ls
brew "fd"                # modern find
brew "fzf"               # fuzzy finder
brew "jq"                # json
brew "ripgrep"           # fast grep
brew "tldr"              # short man pages
brew "tree"
brew "wget"
brew "zoxide"            # smarter cd

# -------------------------------------------------------------------- git ---
brew "git"
brew "gh"                        # github cli
brew "git-delta"                 # nicer diffs (wired up in gitconfig)
brew "lazygit"                   # git tui
brew "git-friendly/git-friendly/git-friendly"

# ---------------------------------------------------------------- runtimes ---
brew "nvm"               # node (the only node manager -- do not also install node/n/nodenv)
brew "rbenv"
brew "ruby-build"
brew "go"
brew "python@3.13"

# -------------------------------------------------------------- data/cloud ---
brew "postgresql@17"
brew "docker"
brew "docker-compose"
brew "flyctl"
brew "firebase-cli"

# ------------------------------------------------------------------ system ---
brew "mas"               # mac app store cli, used by the mas entries below
brew "dockutil"          # scripted Dock editing

# ------------------------------------------------------------------- fonts ---
cask "font-hack"
cask "font-hack-nerd-font"       # powerline/starship glyphs
cask "font-menlo-for-powerline"

# -------------------------------------------------------------------- apps ---
cask "1password"
cask "caffeine"
cask "claude-code"
cask "db-browser-for-sqlite"
cask "discord"
cask "dropbox"
cask "finicky"                   # browser router
cask "firefox"
cask "gcloud-cli"
cask "google-chrome"
cask "iterm2"
cask "karabiner-elements"
cask "notion"
cask "obsidian"
cask "raycast"
cask "rectangle"                 # window management
cask "spotify"
cask "transmission"
cask "visual-studio-code"
cask "vlc"

# ------------------------------------------------------------------- games ---
brew "stockfish"
cask "steam"
# chiaki-ng (PS Remote Play) lives in an untrusted third-party tap, which
# `brew bundle` will not auto-approve. Install it by hand if you want it:
#   brew tap streetpea/streetpea && brew install --cask chiaki-ng

# ----------------------------------------------------------- mac app store ---
mas "Fantastical", id: 975937182
mas "GoodLinks", id: 1474335294
mas "KeyPad", id: 1491684442
mas "Later", id: 1507396839
mas "Save to Raindrop.io", id: 1549370672
mas "Shareful", id: 1522267256
mas "Slack", id: 803453959
mas "Things", id: 904280696
mas "ToothFairy", id: 1191449274
mas "Xcode", id: 497799835

# Media / photo utilities
mas "Batch Exif Editor Pro", id: 1516458522
mas "ExifPurge", id: 784466108
mas "Photo Naminator", id: 1598189356

# Home / music / play
mas "ControllerForHomeKit", id: 1198176727
mas "Tonebridge Guitar Effects", id: 1263858588
mas "Balatro", id: 6502451661
mas "Spring Lite", id: 1637405989

# iWork + GarageBand (free, but re-downloading them by hand is tedious)
mas "GarageBand", id: 682658836
mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
