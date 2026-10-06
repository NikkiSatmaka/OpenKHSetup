#!/usr/bin/env bash

set -euo pipefail

GAMES_DIR="${HOME}/Games"
MODS_DIR="${GAMES_DIR}/mods/kingdom-hearts"
OPENKH_DIR="${MODS_DIR}/openkh"

BATCH_SCRIPT_SRC="https://codeberg.org/KHOmega/KH-Mods-Setup/raw/branch/main/refined_specific/add_registry.bat"
GAME_APP_ID=2552430

if [[ ! "${OPENKH_APP_ID:-}" =~ ^[0-9]+$ ]]; then
    printf 'Error: OPENKH_APP_ID must be set to a numeric Steam app ID.\n' >&2
    exit 1
fi

for command in wget flatpak mktemp; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Error: required command not found: %s\n' "$command" >&2
        exit 1
    fi
done

mkdir -p -- "$OPENKH_DIR"
BATCH_SCRIPT_LOC="$(mktemp "${OPENKH_DIR}/add_registry.XXXXXX.bat")"
trap 'rm -f -- "$BATCH_SCRIPT_LOC"' EXIT

wget --output-document="$BATCH_SCRIPT_LOC" "$BATCH_SCRIPT_SRC"
if [[ ! -s "$BATCH_SCRIPT_LOC" ]]; then
    printf 'Error: downloaded registry batch script is empty.\n' >&2
    exit 1
fi


printf '%s\n' 'Re:Fined Dependency Installer by KHOmega (Flatpak)'
sleep 3

printf '%s\n' 'Now installing...'
sleep 3

flatpak run com.github.Matoking.protontricks "$GAME_APP_ID" -q -f dotnet8 dotnetdesktop8 vcrun6 ucrtbase2019 xaudio29
flatpak run com.github.Matoking.protontricks "$OPENKH_APP_ID" -q -f dotnet8 dotnetdesktop8
flatpak run --filesystem="$OPENKH_DIR" --command=protontricks-launch com.github.Matoking.protontricks --appid "$GAME_APP_ID" "$BATCH_SCRIPT_LOC"
sleep 3

printf '%s\n' 'Cleaning up setup files...'
sleep 3

printf '%s\n' 'Complete. You may now close this window.'
