#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
GAMES_DIR="${HOME}/Games"
MODS_DIR="${GAMES_DIR}/mods/kingdom-hearts"
OPENKH_DIR="${MODS_DIR}/openkh"
ASSETS_DIR="${SCRIPT_DIR}/assets"
OPENKH_RELEASE="https://github.com/OpenKH/OpenKh/releases/download/latest/openkh.zip"

for command in wget unzip rsync mktemp cp; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Error: required command not found: %s\n' "$command" >&2
        exit 1
    fi
done

TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/openkh.XXXXXX")"
trap 'rm -rf -- "$TEMP_DIR"' EXIT

mkdir -p -- "$OPENKH_DIR"

wget --output-document="${TEMP_DIR}/openkh.zip" "$OPENKH_RELEASE"
unzip -o "${TEMP_DIR}/openkh.zip" -d "$TEMP_DIR"

if [[ ! -d "${TEMP_DIR}/openkh" ]]; then
    printf 'Error: downloaded archive does not contain an openkh directory.\n' >&2
    exit 1
fi

rsync -avh --progress --checksum "${TEMP_DIR}/openkh/" "${OPENKH_DIR}/"
if [[ ! -d "$ASSETS_DIR" ]]; then
    printf 'Error: assets directory not found: %s\n' "$ASSETS_DIR" >&2
    exit 1
fi

cp -a -- "$ASSETS_DIR" "$OPENKH_DIR/"

printf 'OpenKH setup complete.\n'
