#!/bin/bash

echo "=== OPTIMIZANDO ANTIX PARA HARDWARE ATOM ==="

echo "→ Desactivando servicios innecesarios..."
sudo update-rc.d -f cups remove
sudo update-rc.d -f avahi-daemon remove
sudo update-rc.d -f bluetooth remove
sudo update-rc.d -f saned remove
sudo update-rc.d -f rsync remove

echo "→ Desactivando compositor (si existe)..."
killall compton 2>/dev/null
sudo apt remove -y compton 2>/dev/null

echo "→ Ajustando IceWM para máximo rendimiento..."
mkdir -p ~/.icewm
cat << 'EOF' > ~/.icewm/preferences
OpaqueMove=0
OpaqueResize=0
ShowTaskBar=1
TaskBarShowCPUStatus=0
TaskBarShowMailboxStatus=0
TaskBarShowNetStatus=0
TaskBarShowAPMStatus=0
EOF

echo "→ Ajustando swappiness..."
echo "10" | sudo tee /proc/sys/vm/swappiness
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf

echo "→ Limpiando temporales..."
sudo apt autoremove -y
sudo apt clean
rm -rf ~/.cache/*

echo "-> Optimizaciones completadas."
