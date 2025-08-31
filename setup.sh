#!/bin/bash

sudo timedatectl set-ntp true

echo "FONT=ter-124b" >> /etc/vconsole.conf
echo "GRUB_FONT=/usr/share/grub/ter-u32b.pf2" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

cp .bashrc /sachs/.bashrc
cp .vimrc /sachs/.vimrc
cp .gitconfig /sachs/.gitconfig

mkdir -p /sachs/.config/i3status
mkdir -p /sachs/.config/foot
mkdir -p /sachs/.config/sway
cp -r .config/* /sachs/.config/
