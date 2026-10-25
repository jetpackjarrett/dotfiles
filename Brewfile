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
cask "claude"                    # desktop app
cask "claude-code"
cask "db-browser-for-sqlite"
cask "discord"
cask "dropbox"
cask "finicky"                   # browser router
cask "firefox"
cask "gcloud-cli"
cask "google-chrome"
cask "mimestream"
cask "iterm2"
cask "karabiner-elements"
cask "obsidian"
cask "rectangle"                 # window management
cask "visual-studio-code"
cask "vlc"

# ----------------------------------------------------------- mac app store ---
mas "Fantastical", id: 975937182
mas "Save to Raindrop.io", id: 1549370672
mas "Slack", id: 803453959
mas "Things", id: 904280696
mas "Xcode", id: 497799835

