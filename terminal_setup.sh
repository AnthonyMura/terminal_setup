#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install required tools
echo "Installing required packages..."
sudo apt install -y curl git python3-pip python3-dev python3-setuptools zsh

# Install `eza` (modern ls replacement) or fallback to `exa`
echo "Installing eza or exa..."
if sudo apt install -y eza; then
    LS_TOOL="eza"
else
    echo "eza is not available. Installing exa as a fallback."
    sudo apt install -y exa
    LS_TOOL="exa"
fi

# Install `thefuck` (command fixer)
echo "Installing thefuck..."
sudo apt install -y python3-dev python3-pip python3-setuptools
pip3 install --user thefuck

# Install `starship` (prompt customizer)
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh

# Check if Visual Studio Code CLI (`code`) is available
if ! command -v code &> /dev/null; then
    echo "Note: Visual Studio Code CLI ('code') is not installed or not in the PATH."
    echo "You can install VS Code and enable the CLI later."
fi

# Configure .zshrc
echo "Configuring .zshrc..."
cat <<EOF >> ~/.zshrc

# --eza or exa (based on availability)--
if command -v eza &> /dev/null; then
    alias ls="eza --long --tree --level=1 --no-filesize --icons=always --no-permissions --no-user"
    alias ls2="eza --long --tree --level=2 --no-filesize --icons=always --no-permissions --no-user"
    alias ls -a="eza --long --tree --level=1 --no-filesize --icons=always --no-permissions --no-user -a"
elif command -v exa &> /dev/null; then
    alias ls="exa --long --tree --level=1 --no-filesize --icons=always --no-permissions --no-user"
    alias ls2="exa --long --tree --level=2 --no-filesize --icons=always --no-permissions --no-user"
    alias ls -a="exa --long --tree --level=1 --no-filesize --icons=always --no-permissions --no-user -a"
fi

# --the fuck (if available)--
if command -v thefuck &> /dev/null; then
    eval \$(thefuck --alias)
    eval \$(thefuck --alias fk)
fi

# --visual studio code--
alias vs='code'

# --starship init--
eval "\$(starship init zsh)"
EOF

# Make Zsh the default shell (optional)
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Apply changes
echo "Applying changes..."
source ~/.zshrc

echo "Setup completed successfully!"
echo "Restart your terminal or run 'source ~/.zshrc' to apply all changes."