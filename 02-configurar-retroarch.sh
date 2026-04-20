#!/bin/bash

echo "=== CONFIGURANDO RETROARCH PARA ATOM N450 + GMA 3150 ==="

CFG_DIR=~/.config/retroarch
mkdir -p "$CFG_DIR"

BACKUP="$CFG_DIR/retroarch.cfg.backup-$(date +%Y%m%d-%H%M%S)"
if [ -f "$CFG_DIR/retroarch.cfg" ]; then
  echo "→ Haciendo backup de retroarch.cfg existente en:"
  echo "   $BACKUP"
  cp "$CFG_DIR/retroarch.cfg" "$BACKUP"
fi

cat << 'EOF' > "$CFG_DIR/retroarch.cfg"
video_vsync = "false"
video_fullscreen = "true"
video_threaded = "true"
video_smooth = "false"
video_shader_enable = "false"
video_scale_integer = "false"
video_aspect_ratio_auto = "true"

rewind_enable = "false"
run_ahead_enabled = "false"
run_ahead_secondary_instance = "false"

audio_enable = "true"
audio_sync = "true"

menu_driver = "ozone"

savestate_auto_save = "false"
savestate_auto_load = "false"

input_enable_hotkey = "escape"
input_exit_emulator = "q"

log_verbosity = "false"
EOF

echo "=== Configuración aplicada en $CFG_DIR/retroarch.cfg ==="
echo "Podés abrir RetroArch y ajustar detalles finos si querés, pero ya está optimizado para tu Atom."
