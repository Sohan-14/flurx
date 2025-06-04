#!/bin/bash

set -e

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

# URL to raw binary file on GitHub
URL="https://raw.githubusercontent.com/sohan-14/flurx/main/fbinaries/$BIN"

# Download binary to /usr/local/bin/flurx
echo "Downloading $BIN from $URL ..."
curl -L "$URL" -o /usr/local/bin/flurx

# Make executable
chmod +x /usr/local/bin/flurx

echo "✅ flurx installed successfully!"
