apt install stow tmux zsh nodejs npm neovim ripgrep -y  # Ghostty Debian ? AppImage
git clone https://codeberg.org/philhansch/dotfiles ~/dotfiles-phansch
cd ~/dotfiles-phansch && stow i3 tmux zsh neovim
mkdir -p ~/.local/share/nvim/lazy
git clone https://github.com/ravitemer/mcphub.nvim ~/.local/share/nvim/lazy/mcphub.nvim
nvim +Lazy  # Lazy.nvim auto-détecte mcphub → :Lazy sync
:MCPHub     # Marketplace prêt !
