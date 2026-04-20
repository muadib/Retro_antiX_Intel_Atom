#!/bin/bash

echo "==========================================="
echo "   EXPANDIR PARTICIÓN DE PERSISTENCIA - RETRO ANTIX"
echo "==========================================="

echo "→ Detectando particiones USB..."
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep -E "sd|usb"

echo ""
read -p "Ingresá el dispositivo USB (ej: sdb): " USB

if [ ! -b "/dev/$USB" ]; then
    echo "ERROR: El dispositivo /dev/$USB no existe."
    exit 1
fi

PERSIST_PART="/dev/${USB}2"

if [ ! -b "$PERSIST_PART" ]; then
    echo "ERROR: No se encontró la partición de persistencia en $PERSIST_PART"
    exit 1
fi

echo "→ Verificando espacio actual..."
df -h "$PERSIST_PART"

echo ""
read -p "¿Querés expandir la partición de persistencia? (si/no): " CONFIRM

if [ "$CONFIRM" != "si" ]; then
    echo "Cancelado."
    exit 1
fi

echo "→ Desmontando partición..."
sudo umount "$PERSIST_PART" 2>/dev/null

echo "→ Expandiendo partición hasta el final del dispositivo..."
sudo parted /dev/$USB --script resizepart 2 100%

echo "→ Redimensionando sistema de archivos ext4..."
sudo e2fsck -f "$PERSIST_PART"
sudo resize2fs "$PERSIST_PART"

echo "→ Montando nuevamente..."
sudo mkdir -p /mnt/persist
sudo mount "$PERSIST_PART" /mnt/persist

echo "→ Espacio final:"
df -h "$PERSIST_PART"

echo "==========================================="
echo "   EXPANSIÓN COMPLETADA"
echo ""
echo " Ahora tu USB persistente tiene más espacio para:"
echo "   ✔ ROMs"
echo "   ✔ Saves"
echo "   ✔ Estados"
echo "   ✔ Configuraciones"
echo "   ✔ Temas"
echo ""
echo " Podés seguir usando tu USB Retro como siempre."
echo "==========================================="
