#!/bin/sh

## MacOS Catalina
#brew install qemu

export QEMU=$(which qemu-system-arm)
export TMP_DIR=~/tmp/qemu-rpi
export RPI_KERNEL=${TMP_DIR}/kernel-qemu-4.14.79-stretch
# export RPI_FS=~/Downloads/rasberry-pi-vpn-lite.img
export RPI_FS=~/Downloads/rasberry-pi-vpn-lite-qemu.img
export PTB_FILE=${TMP_DIR}/versatile-pb.dtb
export IMAGE_FILE=2019-09-26-raspbian-buster-lite.zip
export IMAGE=http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2019-09-30//${IMAGE_FILE}

mkdir -p $TMP_DIR; cd $TMP_DIR

echo ${PWD}
curl https://github.com/dhruvvyas90/qemu-rpi-kernel/blob/master/kernel-qemu-4.14.79-stretch?raw=true -o ${RPI_KERNEL}

curl https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master/versatile-pb.dtb -o ${PTB_FILE}

# wget $IMAGE
# unzip $IMAGE_FILE

$QEMU -kernel ${RPI_KERNEL} -cpu arm1176 -m 256 -M versatilepb -dtb ${PTB_FILE} -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -drive "file=${RPI_FS},index=0,media=disk,format=raw" -net user,hostfwd=tcp::5022-:22 -net nic

ssh -p 5022 pi@localhost
