#!/bin/bash
set -e

echo "Actualizando repositorios"
apt-get update

echo "Instalando dependencias"
apt-get install -y git wget tar bzip2 gcc g++ make patchutils build-essential libproc-processtable-perl linux-headers-$(uname -r)

echo "Creando carpeta de trabajo"
mkdir -p /root/tbsdrivers
cd /root/tbsdrivers

echo "Eliminando compilaciones anteriores"
rm -rf media_build media

echo "Clonando repositorios TBS"
git clone https://github.com/tbsdtv/media_build.git
git clone --depth=1 -b latest https://github.com/tbsdtv/linux_media.git media

echo "Entrando a media_build"
cd media_build

echo "Preparando fuentes"
make dir DIR=../media

echo "Generando configuracion"
make allyesconfig

echo "Compilando"
make -j$(nproc)

echo "Instalando modulos"
make install

echo "Descargando firmware"
cd /root/tbsdrivers
wget -O tbs-tuner-firmwares_v1.0.tar.bz2 https://www.tbsdtv.com/download/document/linux/tbs-tuner-firmwares_v1.0.tar.bz2

echo "Instalando firmware"
tar -xjf tbs-tuner-firmwares_v1.0.tar.bz2 -C /lib/firmware/

echo "Actualizando modulos"
depmod -a

echo "Proceso terminado"
echo "Ahora reinicia con: reboot"
