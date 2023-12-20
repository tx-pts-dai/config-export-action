#!/bin/bash
set -e

chmod +x config_export.sh

config_export.sh "$0" "$1"