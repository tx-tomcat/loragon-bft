#!/bin/bash

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
brew update
brew upgrade

# Install build tools (equivalent to build-essential)
xcode-select --install 2>/dev/null || true

# Install cmake
brew install cmake

# Install rust (non-interactive)
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup default stable

# Install clang (usually comes with Xcode command line tools, but ensure it's available)
brew install llvm

# Install tmux if not already installed
brew install tmux

# Python and pip setup for macOS
# Check if we need to install Python3 via Homebrew
if ! command -v python3 &> /dev/null; then
    brew install python3
fi

# Upgrade pip to latest version
python3 -m pip install --upgrade pip

# Add local bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH=$PATH:~/.local/bin' >> ~/.zshrc
    echo 'export PATH=$PATH:~/.local/bin' >> ~/.bash_profile
fi

# Source the appropriate shell configuration
if [[ $SHELL == *"zsh"* ]]; then
    source ~/.zshrc
else
    source ~/.bash_profile
fi

echo "Setup complete! You may need to restart your terminal or run 'source ~/.zshrc' (or ~/.bash_profile) to update your PATH."
