#!/bin/bash

echo "=== ACTUALIZANDO CORES DE RETROARCH ==="

CORES_DIR=~/.config/retroarch/cores
mkdir -p "$CORES_DIR"

echo "→ Descargando cores livianos recomendados..."

declare -A cores=(
  ["nestopia"]="nestopia_libretro.so"
  ["snes9x2010"]="snes9x2010_libretro.so"
  ["genesis_plus_gx"]="genesis_plus_gx_libretro.so"
  ["mgba"]="mgba_libretro.so"
  ["pcsx_rearmed"]="pcsx_rearmed_libretro.so"
  ["mame2003_plus"]="mame2003_plus_libretro.so"
)

for core in "${!cores[@]}"; do
  echo "→ Descargando $core..."
  wget -q -O "$CORES_DIR/${cores[$core]}" \
  "https://buildbot.libretro.com/stable/1.17.0/linux/x86_64/${cores[$core]}"
done

echo "→ Actualización de cores completada."
