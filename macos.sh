#!/usr/bin/env bash
# macOS system defaults. Idempotent -- re-run after an OS upgrade.
# Some writes need sudo; you will be prompted once.

set -uo pipefail

info() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }

# Close System Settings so it cannot clobber what we write.
osascript -e 'tell application "System Settings" to quit' >/dev/null 2>&1 || true

# Keep sudo alive for the duration of the script. Its output goes to /dev/null so
# the loop does not hold a pipe open after this script exits.
sudo -v
while true; do sudo -n true; /bin/sleep 60; kill -0 "$$" 2>/dev/null || exit; done \
  >/dev/null 2>&1 &
SUDO_KEEPALIVE=$!
trap 'kill "$SUDO_KEEPALIVE" 2>/dev/null' EXIT

# ---------------------------------------------------------------- general ---
info "General"
# Expand save and print panels by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true
# Save to disk, not iCloud, by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
# Disable smart quotes and dashes (they wreck code)
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
# Skip the "are you sure you want to open this?" dialog for downloads
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Quit the printer app once its queue empties
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# Disable the crash reporter dialog
defaults write com.apple.CrashReporter DialogType -string "none"

# -------------------------------------------------------------- screenshots ---
info "Screenshots -> ~/Screenshots"
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "jpg"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture show-thumbnail -bool false

# ----------------------------------------------------------------- security ---
info "Security & power"
# Require the password immediately after sleep or screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Disable hibernation (speeds up entering sleep)
sudo pmset -a hibernatemode 0

# ----------------------------------------------------------------- keyboard ---
info "Keyboard, trackpad & mouse"
# Full keyboard access in all controls (tab through dialogs)
defaults write -g AppleKeyboardUIMode -int 3
# Disable press-and-hold for accented characters in favour of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
# Fast key repeat
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15
# Tap to click, for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.mouse.tapBehavior -int 1
# Disable "natural" scrolling
defaults write -g com.apple.swipescrolldirection -bool false

# --------------------------------------------------------------------- dock ---
info "Dock"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false      # don't reorder Spaces
defaults write com.apple.dock persistent-apps -array      # empty the Dock
defaults write com.apple.dock persistent-others -array

# ------------------------------------------------------------------ menubar ---
info "Menu bar"
defaults write com.apple.menuextra.clock DateFormat -string "MMM d h:mm:ss a"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# ------------------------------------------------------------------- finder ---
info "Finder"
# New windows open in the home folder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"
# List view everywhere, folders on top, search the current folder
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Show all extensions and hidden files; skip the extension-change warning
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Path bar and status bar
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# Sidebar icon size: medium
defaults write -g NSTableViewDefaultSizeMode -int 2
# Mounted volumes on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# Hide desktop icons entirely (Raycast/Spotlight instead)
defaults write com.apple.finder CreateDesktop -bool false
# Keep folders out of network/USB volumes' .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ------------------------------------------------------------------- safari ---
# Safari is sandboxed on recent macOS, so these only take effect if the
# terminal has Full Disk Access. Failures here are not fatal.
info "Safari"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true 2>/dev/null \
  || printf '  (skipped -- grant your terminal Full Disk Access to set Safari prefs)\n'
defaults write com.apple.Safari IncludeDevelopMenu -bool true 2>/dev/null || true

# ------------------------------------------------------------------ restart ---
info "Restarting affected apps"
for app in Dock Finder SystemUIServer; do
  killall "$app" >/dev/null 2>&1 || true
done

printf '\n\033[1;32m  ✓\033[0m macOS defaults applied. Some changes need a logout to show up.\n'
