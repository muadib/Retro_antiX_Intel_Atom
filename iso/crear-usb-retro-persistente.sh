#!/bin/bash

echo "==========================================="
echo "   CREAR USB BOOTEABLE PERSISTENTE - RETRO ANTIX"
echo "==========================================="

ISO_DIR="/home/snapshot"
ISO_FILE=$(ls -t $ISO_DIR/*persistent.iso 2>/dev/null | head -n 1)

if [ -z "$ISO_FILE" ]; then
    echo "ERROR: No se encontró ninguna ISO persistente en /home/snapshot/"
    exit 1
fi

echo "→ ISO detectada:"
echo "   $ISO_FILE"
echo ""

echo "→ Listando dispositivos USB disponibles:"
lsblk -o NAME,SIZE,MODEL,TRAN | grep usb

echo ""
read -p "Ingresá el dispositivo USB (ej: sdb): " USB

if [ ! -b "/dev/$USB" ]; then
    echo "ERROR: El dispositivo /dev/$USB no existe."
    exit 1
fi

echo ""
echo "ADVERTENCIA: /dev/$USB será formateado COMPLETAMENTE."
read -p "¿Confirmás? (si/no): " CONFIRM

if [ "$CONFIRM" != "si" ]; then
    echo "Cancelado."
    exit 1
fi

echo "→ Desmontando particiones..."
sudo umount /dev/${USB}* 2>/dev/null

echo "→ Creando tabla de particiones..."
sudo parted /dev/$USB --script mklabel gpt

echo "→ Creando partición EFI + BOOT..."
sudo parted /dev/$USB --script mkpart primary fat32 1MiB 1024MiB
sudo parted /dev/$USB --script set 1 esp on

echo "→ Creando partición de persistencia..."
sudo parted /dev/$USB --script mkpart primary ext4 1024MiB 100%

echo "→ Formateando particiones..."
sudo mkfs.vfat -F32 /dev/${USB}1
sudo mkfs.ext4 /dev/${USB}2

echo "→ Montando partición BOOT..."
sudo mkdir -p /mnt/usb-boot
sudo mount /dev/${USB}1 /mnt/usb-boot

echo "→ Extrayendo ISO al USB..."
sudo bsdtar -xpf "$ISO_FILE" -C /mnt/usb-boot

echo "→ Instalando GRUB en el USB..."
sudo grub-install --target=x86_64-efi --efi-directory=/mnt/usb-boot --boot-directory=/mnt/usb-boot/boot --removable /dev/$USB

echo "→ Configurando persistencia..."
sudo mkdir -p /mnt/usb-boot/persist
sudo mount /dev/${USB}2 /mnt/usb-boot/persist

echo "→ Creando archivo de configuración de persistencia..."
echo "/ union" | sudo tee /mnt/usb-boot/persist/persistence.conf

echo "→ Ajustando GRUB para activar persistencia..."
GRUB_CFG="/mnt/usb-boot/boot/grub/grub.cfg"
sudo sed -i 's/linux\ /linux\ persistence persistence-media=removable\ /g' "$GRUB_CFG"

echo "→ Desmontando..."
sudo umount /mnt/usb-boot/persist
sudo umount /mnt/usb-boot

echo "==========================================="
echo " USB PERSISTENTE creado correctamente."
echo ""
echo " Ahora podés arrancar desde el USB y:"
echo "   ✔ Guardar ROMs nuevas"
echo "   ✔ Guardar saves"
echo "   ✔ Guardar configuraciones"
echo "   ✔ Guardar estados"
echo "   ✔ Guardar temas"
echo ""
echo " Funciona igual que Batocera, pero con antiX Retro."
echo "==========================================="
