#!/bin/bash

echo "=== OPTIMIZACIÓN PARA INTEL GMA 3150 ==="

echo "→ Instalando drivers de video recomendados..."
sudo apt update
sudo apt install -y xserver-xorg-video-intel mesa-utils

echo "→ Creando configuración Xorg específica para GMA 3150..."
sudo mkdir -p /etc/X11/xorg.conf.d

sudo bash -c 'cat << "EOF" > /etc/X11/xorg.conf.d/20-intel-gma3150.conf
Section "Device"
    Identifier  "Intel GMA3150"
    Driver      "intel"
    Option      "AccelMethod" "uxa"
    Option      "TearFree" "true"
    Option      "DRI" "2"
EndSection
EOF'

echo "→ Ajustando opciones de rendimiento de compositor (si existiera)..."
if command -v compton &> /dev/null; then
  echo "Desactivando compton para evitar sobrecarga en GMA 3150..."
  killall compton 2>/dev/null
  sudo apt remove -y compton
fi

echo "→ Probando aceleración 3D..."
glxinfo | grep "direct rendering"

echo "=== Listo. Reiniciá X (o el sistema) para aplicar los cambios. ==="
