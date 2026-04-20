#!/bin/bash

USER_HOME="/home/$USER"
CONFIG_DIR="$USER_HOME/.config/ES-DE"
SYSTEMS_FILE="$CONFIG_DIR/es_systems.xml"

mkdir -p "$CONFIG_DIR"

echo "=== Generando es_systems.xml automáticamente ==="

cat << EOF > "$SYSTEMS_FILE"
<?xml version="1.0"?>
<systemList>

  <system>
    <name>nes</name>
    <fullname>Nintendo Entertainment System</fullname>
    <path>$USER_HOME/Retro/roms/nes</path>
    <extension>.nes .zip</extension>
    <command>$USER_HOME/Retro/emulators/retroarch-launch.sh nestopia_libretro.so "%ROM_RAW%"</command>
    <platform>nes</platform>
  </system>

  <system>
    <name>snes</name>
    <fullname>Super Nintendo</fullname>
    <path>$USER_HOME/Retro/roms/snes</path>
    <extension>.smc .sfc .zip</extension>
    <command>$USER_HOME/Retro/emulators/retroarch-launch.sh snes9x2010_libretro.so "%ROM_RAW%"</command>
    <platform>snes</platform>
  </system>

  <system>
    <name>gba</name>
    <fullname>Game Boy Advance</fullname>
    <path>$USER_HOME/Retro/roms/gba</path>
    <extension>.gba .zip</extension>
    <command>$USER_HOME/Retro/emulators/retroarch-launch.sh mgba_libretro.so "%ROM_RAW%"</command>
    <platform>gba</platform>
  </system>

  <system>
    <name>megadrive</name>
    <fullname>Sega Mega Drive</fullname>
    <path>$USER_HOME/Retro/roms/megadrive</path>
    <extension>.bin .md .zip</extension>
    <command>$USER_HOME/Retro/emulators/retroarch-launch.sh genesis_plus_gx_libretro.so "%ROM_RAW%"</command>
    <platform>megadrive</platform>
  </system>

  <system>
    <name>psx</name>
    <fullname>PlayStation</fullname>
    <path>$USER_HOME/Retro/roms/psx</path>
    <extension>.bin .cue .img .pbp</extension>
    <command>$USER_HOME/Retro/emulators/pcsxr-launch.sh "%ROM_RAW%"</command>
    <platform>psx</platform>
  </system>

  <system>
    <name>n64</name>
    <fullname>Nintendo 64</fullname>
    <path>$USER_HOME/Retro/roms/n64</path>
    <extension>.z64 .n64 .v64 .zip</extension>
    <command>$USER_HOME/Retro/emulators/mupen64-launch.sh "%ROM_RAW%"</command>
    <platform>n64</platform>
  </system>

  <system>
    <name>mame</name>
    <fullname>MAME 2003 Plus</fullname>
    <path>$USER_HOME/Retro/roms/mame</path>
    <extension>.zip</extension>
    <command>$USER_HOME/Retro/emulators/retroarch-launch.sh mame2003_plus_libretro.so "%ROM_RAW%"</command>
    <platform>arcade</platform>
  </system>

  <system>
    <name>amiga</name>
    <fullname>Commodore Amiga</fullname>
    <path>$USER_HOME/Retro/roms/amiga</path>
    <extension>.adf .hdf .lha</extension>
    <command>$USER_HOME/Retro/emulators/fsuae-launch.sh "%ROM_RAW%"</command>
    <platform>amiga</platform>
  </system>

  <system>
    <name>dos</name>
    <fullname>DOS</fullname>
    <path>$USER_HOME/Retro/roms/dos</path>
    <extension>.exe .bat .com</extension>
    <command>$USER_HOME/Retro/emulators/dosbox-launch.sh "%ROM_RAW%"</command>
    <platform>pc</platform>
  </system>

</systemList>
EOF

echo "=== es_systems.xml generado correctamente en $SYSTEMS_FILE ==="
