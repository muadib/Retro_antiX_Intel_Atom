#!/bin/bash

echo "==========================================="
echo "   CREAR ISO PORTABLE PERSISTENTE - RETRO ANTIX"
echo "==========================================="

USER_HOME="/home/$USER"
SKEL="/etc/skel"
SNAPSHOT_DIR="/home/snapshot"
PERSIST_DIR="/home/persist-retro"
PERSIST_FILE="$PERSIST_DIR/persistence.dat"
PERSIST_SIZE="4096"   # Tamaño en MB (4GB)

echo "→ Verificando iso-snapshot..."
if ! command -v iso-snapshot &> /dev/null; then
    echo "iso-snapshot no está instalado. Instalando..."
    sudo apt update
    sudo apt install -y iso-snapshot
fi

echo "→ Preparando entorno persistente..."
sudo mkdir -p "$PERSIST_DIR"

echo "→ Creando archivo de persistencia de $PERSIST_SIZE MB..."
sudo dd if=/dev/zero of="$PERSIST_FILE" bs=1M count=$PERSIST_SIZE
sudo mkfs.ext4 "$PERSIST_FILE"

echo "→ Copiando entorno Retro a /etc/skel..."
sudo mkdir -p "$SKEL/Retro"
sudo rsync -a "$USER_HOME/Retro/" "$SKEL/Retro/"

echo "→ Copiando configuraciones de ES-DE y RetroArch..."
sudo mkdir -p "$SKEL/.config"

if [ -d "$USER_HOME/.config/ES-DE" ]; then
    sudo rsync -a "$USER_HOME/.config/ES-DE" "$SKEL/.config/"
fi

if [ -d "$USER_HOME/.config/retroarch" ]; then
    sudo rsync -a "$USER_HOME/.config/retroarch" "$SKEL/.config/"
fi

echo "→ Copiando scripts personalizados..."
sudo mkdir -p "$SKEL/scripts-retro"
sudo rsync -a "$USER_HOME"/*.sh "$SKEL/scripts-retro/" 2>/dev/null

echo "→ Limpiando archivos innecesarios..."
sudo rm -rf "$SKEL/Retro/roms/"*/.mame_cache 2>/dev/null
sudo rm -rf "$SKEL/Retro/roms/"*/.DS_Store 2>/dev/null

echo "→ Preparando snapshot..."
sudo mkdir -p "$SNAPSHOT_DIR"

echo "→ Ejecutando iso-snapshot..."
sudo iso-snapshot

echo "→ Agregando soporte de persistencia a la ISO..."
ISO_FILE=$(ls -t /home/snapshot/*.iso | head -n 1)
ISO_NAME=$(basename "$ISO_FILE")
ISO_DIR="/home/snapshot/iso-temp"

echo "→ Montando ISO..."
sudo mkdir -p "$ISO_DIR"
sudo mount -o loop "$ISO_FILE" "$ISO_DIR"

echo "→ Copiando ISO para modificación..."
sudo rsync -a "$ISO_DIR/" "/home/snapshot/${ISO_NAME%.iso}-persistent/"

sudo umount "$ISO_DIR"
sudo rmdir "$ISO_DIR"

echo "→ Agregando archivo de persistencia..."
sudo cp "$PERSIST_FILE" "/home/snapshot/${ISO_NAME%.iso}-persistent/"

echo "→ Modificando menú de arranque para activar persistencia..."
BOOT_CFG="/home/snapshot/${ISO_NAME%.iso}-persistent/boot/grub/grub.cfg"

sudo sed -i 's/linux\ /linux\ persistence persistence-media=removable\ /g' "$BOOT_CFG"

echo "→ Generando nueva ISO persistente..."
cd "/home/snapshot/${ISO_NAME%.iso}-persistent/"
sudo bash -c "grub-mkrescue -o ../${ISO_NAME%.iso}-persistent.iso ."

echo "==========================================="
echo " ISO PERSISTENTE creada:"
echo "   /home/snapshot/${ISO_NAME%.iso}-persistent.iso"
echo ""
echo " Copiala a un USB con:"
echo "   sudo dd if=/home/snapshot/${ISO_NAME%.iso}-persistent.iso of=/dev/sdX bs=4M status=progress"
echo ""
echo " Al arrancar desde USB:"
echo "   ✔ Guarda cambios"
echo "   ✔ Guarda saves"
echo "   ✔ Guarda configuraciones"
echo "   ✔ Guarda ROMs nuevas"
echo "==========================================="
