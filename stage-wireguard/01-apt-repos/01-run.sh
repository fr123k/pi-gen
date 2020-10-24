#!/bin/bash -e

on_chroot << EOF
echo "deb http://deb.debian.org/debian/ unstable main" | tee --append /etc/apt/sources.list.d/unstable.list
apt-key adv --keyserver   keyserver.ubuntu.com --recv-keys 8B48AD6246925553
apt-key adv --keyserver   keyserver.ubuntu.com --recv-keys 7638D0442B90D010
apt-key adv --keyserver   keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC
printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' | tee --append /etc/apt/preferences.d/limit-unstable
apt-get update
sysctl net.ipv4.ip_forward
EOF
