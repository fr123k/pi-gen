#!/bin/bash -e

on_chroot << EOF
dkms status
uname -r
# git clone https://github.com/adrianmihalko/wg_config.git
cd wg_config
wg genkey | tee server_private.key | wg pubkey > server_public.key
cat server_public.key
cat server_private.key
cp wg.def.sample wg.def
cat wg.def
modprobe wireguard && lsmod | grep wireguard
./user.sh -a phone1
sudo touch /etc/wireguard/wg0.conf
systemctl enable wg-quick@wg0
EOF
