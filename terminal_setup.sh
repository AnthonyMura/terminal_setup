#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install required tools
echo "Installing required packages..."
sudo apt install -y curl git python3-pip zsh

# Install `eza` (modern ls replacement)
echo "Installing eza..."
sudo apt install -y eza

# Install `thefuck` (command fixer)
echo "Installing thefuck..."
pip3 install --user thefuck

# Install `starship` (prompt customizer)
echo "Installing starship..."
curl -fsSL https://starship.rs/install.sh | bash -s -- -y

# Check if Visual Studio Code CLI (`code`) is available
if ! command -v code &> /dev/null; then
    echo "Note: Visual Studio Code CLI ('code') is not installed or not in the PATH."
    echo "You can install VS Code and enable the CLI later."
fi

# Configure .zshrc
echo "Configuring .zshrc..."
cat <<EOF >> ~/.zshrc

# --eza--
alias ls="eza --long --tree --level=1 --no-filesize --icons=always --no-permissions --no-user"
alias ls2="eza --long --tree --level=2 --no-filesize --icons=always --no-permissions --no-user"
alias ls -a="eza --long --tree --level=1 --no-filesize --icons=always --no-permissions --no-user -a"

# --the fuck--
eval \$(thefuck --alias)
eval \$(thefuck --alias fk)

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