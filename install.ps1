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
  echo "Windows detected. Please use the PowerShell install script."
  exit 1
else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Downloading flurx from $BINARY_URL ..."

# Use sudo if not root to copy into /usr/local/bin
if [ "$EUID" -ne 0 ]; then
  echo "Root permissions are required. Trying with sudo..."
  curl -L "$BINARY_URL" -o /tmp/flurx
  sudo mv /tmp/flurx /usr/local/bin/flurx
  sudo chmod +x /usr/local/bin/flurx
else
  curl -L "$BINARY_URL" -o /usr/local/bin/flurx
  chmod +x /usr/local/bin/flurx
fi

echo "flurx installed successfully!"
