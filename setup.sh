#!/bin/bash

set -e

sudo timedatectl set-ntp true

sudo bash -c 'echo "FONT=ter-124b" >> /etc/vconsole.conf'
sudo bash -c 'echo "GRUB_FONT=/usr/share/grub/ter-u32b.pf2" >> /etc/default/grub'
sudo grub-mkconfig -o /boot/grub/grub.cfg

cp .bashrc "$HOME/.bashrc"
cp .vimrc "$HOME/.vimrc" 
cp .gitconfig "$HOME/.gitconfig"

mkdir -p "$HOME/.config/i3status"
mkdir -p "$HOME/.config/foot"
mkdir -p "$HOME/.config/sway"

cp -r .config/* "$HOME/.config/"
