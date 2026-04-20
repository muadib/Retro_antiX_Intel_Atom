===========================================
 RETRO ANTIX - DOCUMENTACIÓN DEL SISTEMA
===========================================

Este entorno convierte antiX en una plataforma retro liviana,
optimizada para hardware Intel Atom N450 + GMA 3150.

Incluye:
- ES-DE (frontend)
- RetroArch (AppImage)
- Emuladores externos (PCSX-Reloaded, Mupen64Plus, FS-UAE, DOSBox-Staging)
- Scripts de optimización y mantenimiento
- Estructura estilo Batocera

-------------------------------------------
INSTALACION Y CONFIGURACION
-------------------------------------------

Ejecutar:
    ./00-script-retro-antix.sh

-------------------------------------------
 OPTIMIZAR ANTIX
-------------------------------------------

Ejecutar:

    ./01-optimizar-antix.sh

Esto:
- Desactiva servicios innecesarios
- Optimiza IceWM
- Reduce swappiness
- Limpia temporales

-------------------------------------------
 CONFIGURAR RETROARCH AUTOMÁTICAMENTE
-------------------------------------------

Ejecutar:

    ./02-configurar-retroarch.sh

Genera un retroarch.cfg optimizado para Atom N450.

-------------------------------------------
 OPTIMIZAR VIDEO PARA GMA 3150
-------------------------------------------

Ejecutar:

    ./03-optimizar-gma3150.sh

Esto:
- Instala drivers Intel
- Fuerza AccelMethod=uxa
- Activa TearFree
- Desactiva compositor

-------------------------------------------
 ACTUALIZAR CORES DE RETROARCH
-------------------------------------------

Ubicado en la carpeta extras.
Ejecutar:

    ./actualizar-cores.sh

Esto descarga los cores livianos recomendados:
- nestopia
- snes9x2010
- genesis_plus_gx
- mgba
- pcsx_rearmed
- mame2003_plus


-------------------------------------------
 FRONTEND (ES-DE)
-------------------------------------------

Configuracion

    - Guardar config/ES-DE/es_system.xml en ~/.config/ES-DE/es_systems.xml 
    - Reemplazar USER por el usuario real

ES-DE se ejecuta desde

    ~/Retro/emulators/ES-DE.AppImage

-------------------------------------------
 ESTRUCTURA DE CARPETAS
-------------------------------------------

~/Retro/
    roms/
        nes/
        snes/
        gba/
        megadrive/
        psx/
        n64/
        mame/
        amiga/
        dos/
    bios/
    saves/
    states/
    emulators/
    README.txt

-------------------------------------------
 AGREGAR ROMS
-------------------------------------------

Colocar ROMs en:

    ~/Retro/roms/<sistema>/

Ejemplos:
- NES → ~/Retro/roms/nes/
- PSX → ~/Retro/roms/psx/
- MAME → ~/Retro/roms/mame/

-------------------------------------------
Scripts en carpeta ISO
-------------------------------------------

Estos scripts se corren luego de tener antiX configurado.

- Remasterizar antiX y crear una ISO
    - Genera una ISO instalable, igual que la ISO oficial de antiX
        - Copia tu entorno Retro a /etc/skel
        - Ejecuta iso-snapshot
    - Está pensada para instalar antiX Retro en otra PC
    - La ISO resultante no es portable, no guarda cambios

        Ejecutar:
            ./remaster-retro-antix.sh

- Crear una ISO portable persistente
    - Se puede usar sin instalar
    - Funciona desde USB
        
        Ejecutar:
            ./crear-iso-portable-persistente.sh
        Y para instalarlo en un USB
            ./crear-usb-retro-persistente.sh

-------------------------------------------
 NOTAS
-------------------------------------------

- ES-DE usa es_systems.xml para saber qué emulador usar
    - Script para generarlo automaticamente (si hiciera falta): extras/generar-es-systems.sh 
- Los lanzadores están en ~/Retro/emulators/
- Este entorno está pensado para hardware limitado
