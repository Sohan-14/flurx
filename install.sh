#!/bin/bash
set -e

OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

if [[ "$OS" == "darwin" ]]; then
  if [[ "$ARCH" == "x86_64" ]]; then
    BINARY_URL="https://raw.githubusercontent.com/sohan-14/flurx/main/fbinaries/flurx-macos-x86_64/flurx"
  elif [[ "$ARCH" == "arm64" ]]; then
    BINARY_URL="https://raw.githubusercontent.com/sohan-14/flurx/main/fbinaries/flurx-macos-apple-silicon/flurx"
  else
    echo "Unsupported architecture on macOS: $ARCH"
    exit 1
  fi
elif [[ "$OS" == "linux" ]]; then
  if [[ "$ARCH" == "x86_64" ]]; then
    BINARY_URL="https://raw.githubusercontent.com/sohan-14/flurx/main/fbinaries/flurx-linux-x86_64/flurx"
  else
    echo "Unsupported architecture on Linux: $ARCH"
    exit 1
  fi
elif [[ "$OS" == "windows_nt" || "$OS" == "mingw64_nt" || "$OS" == "msys_nt" ]]; then
  # Windows shell can be complicated; better provide PowerShell install script
  echo "Windows detected. Please use the PowerShell install script:"
  echo "Open PowerShell and run:"
  echo "  iwr -useb https://raw.githubusercontent.com/sohan-14/flurx/main/install.ps1 | iex"
  exit 1
else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Downloading flurx from $BINARY_URL ..."

curl -L -o /usr/local/bin/flurx "$BINARY_URL"
chmod +x /usr/local/bin/flurx

echo "flurx installed successfully!"
