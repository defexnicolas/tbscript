#!/bin/bash

sudo apt-get update
sudo apt-get full-upgrade
sudo apt-get install module-assistant
sudo module-assistant
sudo apt-get install libproc-processtable-perl
mkdir tbsdrivers/
cd tbsdrivers/
git clone https://github.com/tbsdtv/media_build.git
git clone --depth=1 https://github.com/tbsdtv/linux_media.git -b latest ./media
cd media_build/
sudo apt-get install linux-headers-generic
sudo apt-get install patchutils
sudo apt-get install libproc-processtable-perl
sudo apt-get install gcc
make dir DIR=../media
make allyesconfig
make -j4
sudo make install
wget http://www.tbsdtv.com/download/document/linux/tbs-tuner-firmwares_v1.0.tar.bz2
sudo tar jxvf tbs-tuner-firmwares_v1.0.tar.bz2 -C /lib/firmware/

echo Instalacion Exitosa
