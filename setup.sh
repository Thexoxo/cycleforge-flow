#!/bin/bash
# CycleForge Flow: LazyVim + tmux boot-to-nvim (zéro distraction)

apt update && apt install stow tmux zsh neovim nodejs npm ripgrep ghostty default-jdk -y

# Dotfiles (clone ton repo)
git clone https://github.com/TON_USERNAME/cycleforge-flow ~/dotfiles
cd ~/dotfiles && stow i3 tmux zsh nvim

# LazyVim + mcphub (IA/MCP pour RE)
rm -rf ~/.local/share/nvim/lazy
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
cd ~/.config/nvim && nvim +Lazy sync  # Plugins auto
git clone https://github.com/ravitemer/mcphub.nvim ~/.local/share/nvim/lazy/mcphub.nvim
nvim +Lazy sync

# tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf  # <prefix>+I pour plugins

echo "Setup OK ! Reboot → boot tmux/nvim flow."
echo "Super+Enter: tmux panes (nvim/code | term | MCP IA)."
