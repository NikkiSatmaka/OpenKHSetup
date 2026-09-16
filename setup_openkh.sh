#!/usr/bin/env bash

# Variables
GAMES_DIR="${HOME}/Games"
MODS_DIR="${GAMES_DIR}/mods"
OPENKH_DIR="${MODS_DIR}/OpenKH"

DOTNET_RUNTIME_VERSION="8.0.31"
OPENKH_RELEASE="https://github.com/OpenKH/OpenKh/releases/download/latest/openkh.zip"
DOTNET_RUNTIME_RELEASE="https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/${DOTNET_RUNTIME_VERSION}/windowsdesktop-runtime-${DOTNET_RUNTIME_VERSION}-win-x64.exe"

OPENKH_ZIP_LOC="${OPENKH_DIR}/openkh.zip"

# Make a dedicated OpenKH directory
mkdir -p "$OPENKH_DIR" || exit

# Download the latest OpenKH release from GitHub, and .NET runtime into OpenKH directory
wget --output-document="$OPENKH_ZIP_LOC" "$OPENKH_RELEASE"
wget --directory-prefix="$OPENKH_DIR" "$DOTNET_RUNTIME_RELEASE"

# Unzip OpenKH and place it into OpenKH directory, and delete the zip file
unzip "$OPENKH_ZIP_LOC" -d "$OPENKH_DIR"
rm -f "$OPENKH_ZIP_LOC"
exit
