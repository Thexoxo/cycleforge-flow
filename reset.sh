#!/bin/bash
# Full reset debian-z : tous paquets + configs
PAQUETS="i3-wm i3status ly alacritty tmux polybar rofi brave-browser firefox-esr vim stow feh sxhkd brave-browser neovim picom dunst"
apt purge $PAQUETS -y
apt autoremove --purge -y && apt autoclean
rm -rf ~/.config/i3 ~/.config/alacritty ~/.tmux* ~/.vim* ~/.bashrc ~/.profile ~/.zshrc ~/.xinitrc ~/.Xresources ~/.fehbg ~/.config/polybar ~/.config/rofi ~/.config/sxhkd ~/.local/share/applications/*
rm -f /etc/X11/xinit/xclients /etc/X11/xorg.conf.d/*
systemctl set-default multi-user.target
echo "FULL RESET debian-z OK. reboot -> TTY pur (Ctrl+Alt+F2)."
