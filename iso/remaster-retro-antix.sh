#!/bin/bash

echo "=== REMASTER RETRO ANTIX ==="
echo "Este script asume que estás en antiX y que ya tenés todo tu entorno Retro configurado."

echo "→ Verificando herramientas de remaster..."
if ! command -v iso-snapshot &> /dev/null; then
  echo "iso-snapshot no encontrado. Instalando..."
  sudo apt update
  sudo apt install -y iso-snapshot
fi

SNAPSHOT_DIR=~/iso-snapshot-retro
mkdir -p "$SNAPSHOT_DIR"

echo "→ Copiando configuración retro a /etc/skel para que se incluya en la ISO..."
sudo mkdir -p /etc/skel/Retro
sudo rsync -a ~/Retro/ /etc/skel/Retro/

echo "→ Copiando configuración de ES-DE y RetroArch a /etc/skel..."
sudo mkdir -p /etc/skel/.config
if [ -d ~/.config/ES-DE ]; then
  sudo rsync -a ~/.config/ES-DE /etc/skel/.config/
fi
if [ -d ~/.config/retroarch ]; then
  sudo rsync -a ~/.config/retroarch /etc/skel/.config/
fi

echo "→ Ejecutando iso-snapshot (modo personalizado)..."
sudo iso-snapshot

echo "=== Proceso terminado ==="
echo "Buscá tu ISO en /home/snapshot o en la carpeta configurada por iso-snapshot."
