#!/bin/bash
set -e  # Stop sur erreur

apt update && apt install stow tmux zsh neovim nodejs npm ripgrep default-jdk curl wget unzip alacritty -y

# Clone & auto-créer structure stow (fix empty folders)
git clone https://github.com/Thexoxo/cycleforge-flow ~/dotfiles || (rm -rf ~/dotfiles && git clone https://github.com/Thexoxo/cycleforge-flow ~/dotfiles)
cd ~/dotfiles

# Créer folders si manquants + fichiers
mkdir -p i3 tmux zsh nvim/lua/config

# Injecter configs direct (pas besoin push)
cat > i3/config << 'EOF'
set $mod Mod4
exec_always tmux attach -t flow || tmux new -s flow -d 'nvim ~/' 'split-window -h' 'split-window -v zsh'
bindsym $mod+i exec alacritty -e ranger ~/binaryninja
bindsym $mod+o exec alacritty -e ranger ~/Vault
bindsym $mod+Return exec alacritty -e tmux attach -t flow
bindsym $mod+Shift+q kill
EOF

cat > tmux/tmux.conf << 'EOF'
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g prefix C-a
bind C-a send-prefix
run '~/.tmux/plugins/tpm/bindings/install_plugins'
EOF

cat > zsh/.zshrc << 'EOF'
alias flow='tmux attach -t flow || tmux new -s flow'
alias mcp='nvim +MCPHub'
chsh -s $(which zsh)
EOF

cat > nvim/lua/config/keymaps.lua << 'EOF'
local map = vim.keymap.set
map('n', '<leader>bn', ':echo "Binja MCP ready"<CR>', { desc = 'Binja MCP' })
map('n', '<leader>ob', ':echo "Obsidian note ready"<CR>', { desc = 'Obsidian' })
EOF

# Stow tout
stow i3 tmux zsh nvim

# LazyVim CLEAN install
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git
nvim --headless -c 'autocmd User LazySync quitall' -c 'Lazy sync' -c 'qa'

# MCPHub
mkdir -p ~/.local/share/nvim/lazy/mcphub.nvim
cd ~/.local/share/nvim/lazy/mcphub.nvim
git clone https://github.com/ravitemer/mcphub.nvim . && npm i
cd ~/.config/nvim && nvim --headless -c 'Lazy sync' -c 'qa'

# Tmux
mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf 2>/dev/null || echo "Tmux conf loaded post-reboot"

echo "✅ FIXED ! Reboot MAINTENANT → tmux/nvim flow."
echo "Test sans reboot: tmux attach -t flow"
echo "Super+i: Binja folder | Super+o: Obsidian | C-a hjkl: nav"
