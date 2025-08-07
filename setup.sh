#!/bin/bash
timedatectl set-ntp true
echo "FONT=ter-124b" >> /etc/vconsole.conf
echo "GRUB_FONT=/usr/share/grub/ter-u32b.pf2" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
