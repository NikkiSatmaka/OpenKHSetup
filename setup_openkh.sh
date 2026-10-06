#!/usr/bin/env bash

set -euo pipefail

# Variables
GAMES_DIR="${HOME}/Games"
MODS_DIR="${GAMES_DIR}/mods/kingdom-hearts"
OPENKH_DIR="${MODS_DIR}/OpenKH"

OPENKH_RELEASE="https://github.com/OpenKH/OpenKh/releases/download/latest/openkh.zip"

OPENKH_ZIP_LOC="${OPENKH_DIR}/openkh.zip"

# Make a dedicated OpenKH directory
mkdir -p "$OPENKH_DIR" || exit

# Download the latest OpenKH release from GitHub, and .NET runtime into OpenKH directory
wget --output-document="$OPENKH_ZIP_LOC" "$OPENKH_RELEASE"

# Unzip OpenKH and place it into OpenKH directory, and delete the zip file
unzip "$OPENKH_ZIP_LOC" -d "$OPENKH_DIR"
rm -f "$OPENKH_ZIP_LOC"
exit
