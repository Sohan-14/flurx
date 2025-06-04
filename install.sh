#!/bin/bash

set -e

# Detect OS and Arch
OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

if [[ "$OS" == "darwin" ]]; then
  if [[ "$ARCH" == "arm64" ]]; then
    BIN="flurx-macos-apple-silicon/flurx"
  else
    BIN="flurx-macos/flurx"
  fi
elif [[ "$OS" == "linux" ]]; then
  BIN="flurx-linux/flurx"
elif [[ "$OS" == "windows_nt" ]] || [[ "$OS" == "mingw"* ]]; then
  BIN="flurx-windows/flurx.exe"
else
  echo "Unsupported OS: $OS"
  exit 1
fi

URL="https://raw.githubusercontent.com/sohan-14/flurx/main/fbinaries/$BIN"
DEST="/usr/local/bin/flurx"

echo "Downloading $BIN from $URL ..."
curl -L "$URL" -o "$DEST"

chmod +x "$DEST"

echo "✅ Installed flurx successfully at $DEST"
