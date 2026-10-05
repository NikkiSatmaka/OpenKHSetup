#!/usr/bin/env bash

# Variables
GAMES_DIR="${HOME}/Games"
MODS_DIR="${GAMES_DIR}/mods/kingdom-hearts"
OPENKH_DIR="${MODS_DIR}/OpenKH"

BATCH_SCRIPT_SRC="https://codeberg.org/KHOmega/KH-Mods-Setup/raw/branch/main/refined_specific/add_registry.bat"
BATCH_SCRIPT_LOC="${OPENKH_DIR}/add_registry.bat"

GAME_APP_ID=2552430

# Make a dedicated OpenKH directory
mkdir -p "$OPENKH_DIR" || exit

# Download the batch script to add registry entry
wget --output-document="$BATCH_SCRIPT_LOC" "$BATCH_SCRIPT_SRC"

echo "Re:Fined Dependency Installer by KHOmega (Flatpak)"
sleep 3

echo "Now installing..."
sleep 3

flatpak run com.github.Matoking.protontricks $GAME_APP_ID -q -f dotnet8 dotnetdesktop8 vcrun6 ucrtbase2019 xaudio29
flatpak run --filesystem="$OPENKH_DIR" --command=protontricks-launch com.github.Matoking.protontricks --appid $GAME_APP_ID "$BATCH_SCRIPT_LOC"
sleep 3

echo "Cleaning up setup files..."
sleep 3

rm "$BATCH_SCRIPT_LOC"
echo "Complete. You may now close this window."

exit
