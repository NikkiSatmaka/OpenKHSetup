#!/usr/bin/env bash

set -euo pipefail

# Variables
GAMES_DIR="${HOME}/Games"
MODS_DIR="${GAMES_DIR}/mods/kingdom-hearts"
OPENKH_DIR="${MODS_DIR}/openkh"
TEMP_DIR=/tmp/OpenKHTemp

OPENKH_RELEASE="https://github.com/OpenKH/OpenKh/releases/download/latest/openkh.zip"

OPENKH_ZIP_LOC="${TEMP_DIR}/openkh.zip"

# Make a dedicated OpenKH and TEMP directory
mkdir -p "$OPENKH_DIR" || exit
mkdir -p "$TEMP_DIR" || exit

# Download the latest OpenKH release from GitHub
wget --output-document="$OPENKH_ZIP_LOC" "$OPENKH_RELEASE"

# Unzip OpenKH to the TEMP directory and copy it into OpenKH directory
unzip -o "$OPENKH_ZIP_LOC" -d "$TEMP_DIR"
rsync -avh --progress --checksum "${TEMP_DIR}/openkh/" "${OPENKH_DIR}"

# Delete the TEMP directory
rm -rf "$TEMP_DIR"
exit
