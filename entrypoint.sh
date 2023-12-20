#!/bin/bash
set -e

CONFIG_PATH=$(realpath "$1")
ENVIRONMENT="$2"

chmod +x config_export.sh

./config_export.sh "$CONFIG_PATH" "$ENVIRONMENT"
