#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${TOUGE_TOOLCHAIN_CACHE:-$HOME/.cache/touge-toolchain}"
mkdir -p "$DEST/rust" "$DEST/bin" "$DEST"
if [ ! -x "$DEST/rust/bin/cargo" ]; then
  cat "$SCRIPT_DIR"/dist/rust-1.85.0-linux-x64.tar.xz.part_* | tar -xJf - -C "$DEST/rust"
fi
if [ ! -x "$DEST/bin" ] || [ ! -x "$DEST/bin/godot4" ]; then
  cat "$SCRIPT_DIR"/dist/godot-4.3-linux-x64.tar.xz.part_* | tar -xJf - -C "$DEST/bin"
fi
if [ ! -d "$DEST/vendor" ]; then
  tar -xJf "$SCRIPT_DIR/dist/cargo-vendor.tar.xz" -C "$DEST"
fi
export PATH="$DEST/rust/bin:$DEST/bin:$PATH"
rustc --version
cargo --version
godot4 --version
