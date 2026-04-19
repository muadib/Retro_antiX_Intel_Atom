#!/bin/bash

echo "=== Creando estructura estilo Batocera ==="
mkdir -p ~/Retro/{roms,bios,saves,states,emulators}
mkdir -p ~/Retro/roms/{nes,snes,gba,megadrive,psx,n64,mame,amiga,dos}

echo "=== Instalando dependencias ==="
sudo apt update
sudo apt install -y pcsxr mupen64plus fs-uae dosbox-staging curl wget unzip

echo "=== Descargando ES-DE AppImage ==="
cd ~/Retro/emulators
wget -O ES-DE.AppImage https://github.com/ES-DE/ES-DE/releases/latest/download/ES-DE-x86_64.AppImage
chmod +x ES-DE.AppImage

echo "=== Descargando RetroArch AppImage ==="
wget -O retroarch.AppImage https://buildbot.libretro.com/stable/1.17.0/linux/x86_64/RetroArch.7z
7z x RetroArch.7z
mv RetroArch.AppImage retroarch.AppImage
chmod +x retroarch.AppImage
rm RetroArch.7z

echo "=== Creando lanzadores ==="

# RetroArch launcher
cat << 'EOF' > ~/Retro/emulators/retroarch-launch.sh
#!/bin/bash
/home/$USER/Retro/emulators/retroarch.AppImage -L "$1" "$2"
EOF
chmod +x ~/Retro/emulators/retroarch-launch.sh

# PCSX-Reloaded launcher
cat << 'EOF' > ~/Retro/emulators/pcsxr-launch.sh
#!/bin/bash
pcsxr "$1"
EOF
chmod +x ~/Retro/emulators/pcsxr-launch.sh

# Mupen64Plus launcher
cat << 'EOF' > ~/Retro/emulators/mupen64-launch.sh
#!/bin/bash
mupen64plus "$1"
EOF
chmod +x ~/Retro/emulators/mupen64-launch.sh

# FS-UAE launcher
cat << 'EOF' > ~/Retro/emulators/fsuae-launch.sh
#!/bin/bash
fs-uae "$1"
EOF
chmod +x ~/Retro/emulators/fsuae-launch.sh

# DOSBox launcher
cat << 'EOF' > ~/Retro/emulators/dosbox-launch.sh
#!/bin/bash
dosbox-staging "$1"
EOF
chmod +x ~/Retro/emulators/dosbox-launch.sh

echo "=== Instalación completada ==="
echo "Podés ejecutar ES-DE desde: ~/Retro/emulators/ES-DE.AppImage"
