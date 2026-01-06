#!/usr/bin/env bash
#Version 2.0.0

set -euo pipefail

# Configuracion
WALLPAPER_DIR="${HOME}/Imaxes/FP"
CONFIG_FILE="${HOME}/.config/hypr/hyprpaper.conf"
ROTATION_INTERVAL="${ROTATION_INTERVAL:-900}"
SOCKET="$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"
ESPERA=5

#
# Rutinas
#

obtener_monitores()
{
    hyprctl monitors -j | jq -r '.[].name'
}

escoger_fondo()
{
    local archivos=()
    while IFS= read -r -d $'\0'; do
        archivos+=("$REPLY")
    done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0)

    if [ ${#archivos[@]} -eq 0 ]; then
        echo "Non atopei ningún fondo de pantalla en: $WALLPAPER_DIR" >&2
        return 1
    fi

    echo "${archivos[RANDOM % ${#archivos[@]}]}"
}



establecer_todos_os_fondos()
{
    # for monitor in $(obtener_monitores); do
        # usar_fondo "$monitor"
    # done
    local config_file
    config_file=$(mktemp /tmp/hyprpaper_XXXXXX.conf)
    
    echo "" >> "$config_file"

    for monitor in $(obtener_monitores); do
        local fondo
        fondo=$(escoger_fondo) || continue
        echo -e "wallpaper {\n monitor = $monitor\n path = $fondo  \n }" >> "$config_file"
        echo "[$(date +%T)] Poñendo $fondo no monitor: $monitor"
    done

    pkill hyprpaper || true
    hyprpaper -c "$config_file" &

    cat $config_file
}

#
# Main
#

while [ ! -S "$SOCKET" ]; do
    sleep 0.1
done

ULTIMO_EVENTO=0

(
     while  true; do
            AHORA=$(date +%s)

            if (( AHORA- ULTIMO_EVENTO >= ESPERA )); then
                echo "[$(date +%T)] rotando..."
                establecer_todos_os_fondos
            fi
            sleep "$ROTATION_INTERVAL"
        done
        ) &


        # Listen for monitor hotplug events
        socat - UNIX-CONNECT:"$SOCKET" | while read -r event; do
        case "$event" in
            monitoradded*|monitorremoved*)
                echo "[$(date +%T)] Monitor change detected: $event"
                sleep 0.3  # avoid rapid rebounce
                establecer_todos_os_fondos
                ;;
        esac
    done
