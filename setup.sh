#!/usr/bin/env bash
# One-time setup: point chezmoi at this repo and apply it.
# After this, daily use is just `chezmoi apply`.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

if ! command -v chezmoi >/dev/null 2>&1; then
  echo "chezmoi is not installed."
  echo "Install it first, then re-run this script:"
  echo "  sudo pacman -S chezmoi"
  exit 1
fi

# Point chezmoi at this repo so the repo IS the source of truth.
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/chezmoi"
mkdir -p "$CONFIG_DIR"
printf 'sourceDir = "%s"\n' "$DIR" > "$CONFIG_DIR/chezmoi.toml"

# --force adopts files that already exist in $HOME on this first run.
chezmoi apply --force

echo
echo "Done. Your home config now tracks: $DIR"
echo
echo "Restore packages on a fresh machine with:"
echo "  sudo pacman -S --needed - < pkglist.txt    # native"
echo "  yay -S --needed - < aurlist.txt            # AUR"
