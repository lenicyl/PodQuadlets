#!/bin/bash

STOW="$(command -v stow)"
[ ! -x "$STOW" ] && echo "Stow is not installed. Exiting" && exit 1

CONFIG="$1"

QUADLET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/containers/systemd/$CONFIG"

"$STOW" --verbose \
	--target "$QUADLET_DIR" \
	--delete "$CONFIG" \
	"${@:2}"

rm -rv -- "$QUADLET_DIR"
