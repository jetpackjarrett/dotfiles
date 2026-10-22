# dotfiles

macOS setup: zsh (antidote + starship), git, Homebrew packages, iTerm2, Karabiner,
Claude Code, and a pile of macOS defaults.

## New machine

One command, from a stock macOS install:

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/jetpackjarrett/dotfiles/main/install.sh)
```

That installs the Xcode Command Line Tools and Homebrew, clones this repo to
`~/.dotfiles`, and runs `setup.sh`. Expect it to take a while — the Brewfile is
large — and to be asked for your password once for the `sudo` writes.

Afterwards, `setup.sh` prints the handful of things that genuinely cannot be
scripted (App Store sign-in, Karabiner's input-monitoring permission, SSH key,
app logins).

## Day to day

```sh
./setup.sh          # everything, safe to re-run
./setup.sh link     # symlinks only
./setup.sh brew     # Brewfile only
./setup.sh macos    # macOS defaults only
./setup.sh iterm    # point iTerm2 at the tracked prefs
```

`dotup` (a shell function from `zshrc`) pulls this repo, syncs the Brewfile,
upgrades Homebrew and the zsh plugins, then restarts your shell.

## What's here

| Path | Linked to | What it is |
| --- | --- | --- |
| `zshrc` | `~/.zshrc` | shell config; machine-specific bits go in `~/.zshrc.local` |
| `zsh_plugins.txt` | — | antidote plugin bundle |
| `starship.toml` | — | prompt (loaded via `$STARSHIP_CONFIG`) |
| `gitconfig` | `~/.gitconfig` | git config + aliases; overrides go in `~/.gitconfig.local` |
| `gitignore_global` | `~/.gitignore_global` | global git excludes |
| `Brewfile` | — | every formula, cask and App Store app |
| `claude/settings.json` | `~/.claude/settings.json` | Claude Code settings and hooks |
| `karabiner/karabiner.json` | `~/.config/karabiner/karabiner.json` | key remaps |
| `bin/cc-status` | `~/.config/iterm2/cc-status` | iTerm2 status helper the Claude hooks call |
| `iTerm/` | — | iTerm2 reads prefs straight from here |
| `install.sh` | — | fresh-machine bootstrap |
| `setup.sh` | — | linking + packages + defaults |
| `macos.sh` | — | `defaults write` system tweaks |

Files `setup.sh` replaces are moved aside as `*.backup.<timestamp>` rather than
deleted.

### Not tracked on purpose

Secrets and per-machine settings: `~/.zshrc.local` (holds `$DOTFILES` and any
work paths) and `~/.gitconfig.local` (identity overrides). Both are created
empty by `setup.sh`.

## Usage

Fork and change freely. Most of it is macOS-only, and you'll want your own
identity in `gitconfig` and your own apps in the `Brewfile`.
