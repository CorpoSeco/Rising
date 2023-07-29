#!/bin/bash

set -e

#pkg install android-tools
#pkg install e2fsprogs

if [ -f "$1" ];then
    srcFile="$1"
fi

if [ ! -f "$srcFile" ];then
	echo "Usage: bash ROtoRW.sh  [/path/to/system.img]"
	exit 1
fi

simg2img "$srcFile" system-rw.img || mv "$srcFile" system-rw.img

e2fsck -y -f system-rw.img
resize2fs system-rw.img 4500M
e2fsck -E unshare_blocks -y -f system-rw.img
e2fsck -f -y system-rw.img || true
resize2fs -M system-rw.img
