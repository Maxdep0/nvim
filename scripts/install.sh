#!/usr/bin/env bash
set -euo pipefail

if [[ $USER != "maxdep" ]]; then
    echo "This script is only for user maxdep"
    exit 1
fi

export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"

[ -d "$XDG_DOWNLOAD_DIR/neovim" ] && sudo rm -rf "$XDG_DOWNLOAD_DIR/neovim"
[ -d "/usr/local/share/nvim" ] && sudo rm -rf "/usr/local/share/nvim"
[ -d "$HOME/.local/share/nvim" ] && sudo rm -rf "$HOME/.local/share/nvim"
[ -d "$HOME/.cache/nvim" ] && sudo rm -rf "$HOME/.cache/nvim"
[ -f "$HOME/.config/nvim/lazy-lock.json" ] && sudo rm -f "$HOME/.config/nvim/lazy-lock.json"
[ -d "$HOME/.local/state/nvim" ] && sudo rm -rf "$HOME/.local/state/nvim"

git clone https://github.com/neovim/neovim "$XDG_DOWNLOAD_DIR/neovim" || exit 1
make --directory="$XDG_DOWNLOAD_DIR/neovim" CMAKE_BUILD_TYPE=Release || exit 1
sudo make --directory="$XDG_DOWNLOAD_DIR/neovim" install || exit 1

[ -d "$XDG_DOWNLOAD_DIR/neovim" ] && sudo rm -rf "$XDG_DOWNLOAD_DIR/neovim"
exit 0
