#!/usr/bin/env bash
set -euo pipefail

CONFIG="$HOME/dotfiles/wezterm/.config/wezterm/wezterm.lua"

if [[ $USER != "maxdep" ]]; then
    exit 0
fi

if [[ -z "${TERM_PROGRAM:-}" || "${TERM_PROGRAM}" != "WezTerm" ]]; then
    exit 0
fi

if [[ ! -f "$CONFIG" ]]; then
    exit 0
fi

value="$1" # expected "true" or "false"
sed -i "s/^[[:space:]]*use_fancy_tab_bar[[:space:]]*=.*/use_fancy_tab_bar = ${value},/" "$CONFIG"
