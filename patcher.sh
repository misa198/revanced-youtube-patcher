#!/usr/bin/env bash

set -e

CLI_JAR=$(ls revanced-cli-*-all.jar | head -n 1)
PATCHES_FILE=$(ls patches-*.rvp | head -n 1)
JAVA_BIN="java"

if [ $# -ne 1 ]; then
  echo "Usage: $0 <original.apk>"
  exit 1
fi

INPUT_APK="$1"

if [ ! -f "$INPUT_APK" ]; then
  echo "Error: File not found: $INPUT_APK"
  exit 1
fi

if [ ! -f "$CLI_JAR" ]; then
  echo "Error: Missing $CLI_JAR"
  exit 1
fi

if [ ! -f "$PATCHES_FILE" ]; then
  echo "Error: Missing $PATCHES_FILE"
  exit 1
fi

BASENAME="$(basename "$INPUT_APK")"
FILENAME="${BASENAME%.*}"

echo "==> Patching $INPUT_APK"
echo "==> Using patches: $PATCHES_FILE"

$JAVA_BIN -jar "$CLI_JAR" patch \
  -b \
  -p "$PATCHES_FILE" \
  "$INPUT_APK"

PATCHED_DEFAULT="${FILENAME}-patched.apk"
OUTPUT_APK="revanced_${FILENAME}.apk"

if [ -f "$PATCHED_DEFAULT" ]; then
  mv "$PATCHED_DEFAULT" "$OUTPUT_APK"
  echo "==> Done."
  echo "Generated: $OUTPUT_APK"
else
  echo "Error: Expected patched file not found."
  exit 1
fi
