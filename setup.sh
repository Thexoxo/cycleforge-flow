#!/bin/bash
apt update && apt install stow tmux zsh neovim nodejs npm ripgrep default-jdk curl gnupg lsb-release -y
curl -sS https://debian.griffo.io/3B9335DF576D3D58059C6AA50B56A1A69762E9FF.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/debian.griffo.io.list
apt update && apt install ghostty -y
git clone https://github.com/Thexoxo/cycleforge-flow ~/dotfiles
cd ~/dotfiles && stow i3 tmux zsh nvim
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git
nvim --headless -c 'autocmd User LazySync quitall' -c 'Lazy sync' -c 'qa'
mkdir -p ~/.local/share/nvim/lazy && cd ~/.local/share/nvim/lazy
git clone https://github.com/ravitemer/mcphub.nvim mcphub.nvim && cd mcphub.nvim && npm i
cd ~/.config/nvim && nvim --headless -c 'Lazy sync' -c 'qa'
mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf
echo "ZERO FLEMME OK ! Reboot -> flow." 