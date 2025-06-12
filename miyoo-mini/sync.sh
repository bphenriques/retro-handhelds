#!/usr/bin/env bash
set -ou pipefail

fatal() { printf '[FAIL] %s\n' "$1" 1>&2; exit 1; }

# Constants
SKYSCRAPER_FLAGS=unattend,onlymissing,relative,nohints,skipped,nobrackets
SKYSCRAPER_TEMPLATE=artwork.xml

scrape() {
  local platform="$1"
  local target_roms_dir="$2"

  if ! test -d "$target_roms_dir"; then
    echo "$target_roms_dir does not exist!"
    return 1
  fi

  # Scrap to cache
  Skyscraper -p "${platform}" -i "$target_roms_dir" \
    --flags "${SKYSCRAPER_FLAGS}" \
    -s screenscraper \
    -u "$PLATFORM_LOGIN"

  # Generate and export artwork
  Skyscraper -p "${platform}" -i "$target_roms_dir" \
    --flags "${SKYSCRAPER_FLAGS}" \
    -a "${SKYSCRAPER_TEMPLATE}" \
    -g "$target_roms_dir" \
    --gamelistfilename "miyoogamelist.xml" \
    -o "$target_roms_dir"/Imgs
}

sync() {
  local from="$1"
  local to="$2"
  local bios_from="${3:-}"
  local bios_to="${4:-}"

  echo "syncing $from with $to"
  rsync -h --progress --no-links -r --mkpath --update --delete \
    --exclude-from=rsync-exclude \
    --delete-excluded '*.db' \
    "$from/" "${OUTPUT_DIR}/Roms/$to"

  if ! test -z "$bios_from"; then
    echo "Syncing bios file"
    rsync -h --progress --mkpath --no-links -r --update "${BIOS_DIR}/$bios_from" "${OUTPUT_DIR}/BIOS/$bios_to"
  fi
}

sync_all() {
  sync "${ROMS_DIR}"/gb         GB        gb_bios.bin       gb_bios.bin
  sync "${ROMS_DIR}"/gbc        GBC       gbc_bios.bin      gbc_bios.bin
  sync "${ROMS_DIR}"/gba        GBA       gba_bios.bin      gba_bios.bin
  sync "${ROMS_DIR}"/fbneo      ARCADE
  sync "${ROMS_DIR}"/nes        FC
  sync "${ROMS_DIR}"/snes       SFC
  sync "${ROMS_DIR}"/megadrive  MD
  sync "${ROMS_DIR}"/pico8      PICO
}

scrape_all() {
  scrape gb        "$OUTPUT_DIR"/Roms/GB
  scrape gbc       "$OUTPUT_DIR"/Roms/GBC
  scrape gba       "$OUTPUT_DIR"/Roms/GBA
  scrape arcade    "$OUTPUT_DIR"/Roms/ARCADE
  scrape nes       "$OUTPUT_DIR"/Roms/FC
  scrape snes      "$OUTPUT_DIR"/Roms/SFC
  scrape megadrive "$OUTPUT_DIR"/Roms/MD
}

fix_rtc() {
  mkdir -p "$OUTPUT_DIR"/.tmp_update
  touch "$OUTPUT_DIR"/.tmp_update/.noTimeRestore
}

sync_extra_files() {
  if test -d "${EXTRA_FILES:-}"; then
    rsync -h --progress --mkpath --no-links -r --update "${EXTRA_FILES:-}"/ "$OUTPUT_DIR"
  fi
}

fix_reported_resolution() {
  if test -f "$OUTPUT_DIR"/.autorun.inf && grep -s Onion-v4.3.1-1 < autorun.inf; then
    echo "Fixing reported resolution in Miyoo Mini V4 as it is using a version of OnionOS that does not have the fix"
    sed -i '631s/miyoo_version=202310271401/miyoo_version=202407211632/' "$OUTPUT_DIR"/.tmp_update/runtime.sh
  fi
}

! test -f .env && fatal ".env does not exist!"
# shellcheck disable=SC1091
source .env

! test -f .env.private && fatal ".env.private does not exist!"
# shellcheck disable=SC1091
source .env.private

test -d "$ROMS_DIR" || fatal "Roms dir is not a folder or does not exist: $ROMS_DIR"
test -d "$BIOS_DIR" || fatal "Bios dir is not a folder or does not exist: $BIOS_DIR"
test -d "$OUTPUT_DIR" || fatal "Output dir is not a folder or does not exist: $OUTPUT_DIR"

sync_all
scrape_all
fix_rtc
sync_extra_files
fix_reported_resolution
