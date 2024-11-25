# Modern ls replacement (eza or exa)
if command -v eza &> /dev/null; then
    alias ls="eza --tree --level=1 --icons --no-permissions"
    alias ll="eza --tree --level=2 --icons --no-permissions"
    alias la="eza --tree --level=1 --icons --no-permissions -a"
elif command -v exa &> /dev/null; then
    alias ls="exa -l -T --level=1"
    alias ll="exa -l -T --level=2"
    alias la="exa -l -T --level=1 -a"
fi

# Thefuck alias (command fixer)
if command -v thefuck &> /dev/null; then
    eval "$(thefuck --alias)"
    eval "$(thefuck --alias fk)"
fi

# Visual Studio Code alias
alias vs="code"

# Starship prompt initialization
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
