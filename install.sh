#!/bin/bash

set -e

# Detect OS and ARCH
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

# Download or copy the binary from GitHub repo
# If install.sh runs inside repo, copy; else download
# For example, for GitHub raw URL:
# curl -L "https://github.com/yourusername/flurx/releases/latest/download/$BIN" -o /usr/local/bin/flurx

# For local copy (during testing):
cp "fbinaries/$BIN" /usr/local/bin/flurx
chmod +x /usr/local/bin/flurx

echo "✅ flurx installed successfully!"
