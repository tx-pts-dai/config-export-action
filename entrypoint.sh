#!/bin/bash
set -e

DEBUG='false'

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
FULLPATH=$(readlink -f "$1")
ENVIRONMENT="$2"

if [ $DEBUG == 'true' ]; then
  set -x
  echo "SCRIPT: $SCRIPT"
  echo "SCRIPTPATH: $SCRIPTPATH"
  echo "FULLPATH: $FULLPATH"s
  echo "ENVIRONMENT: $ENVIRONMENT"
fi

# we could curl the config here but for now we'll use a file from the repo. TODO: make this configurable
# curl -o $SCRIPTPATH/config.yaml https://raw.githubusercontent.com/tx-pts-dai/repo_name/main/.github/config.yaml
chmod +x $SCRIPTPATH/config_export.sh

$SCRIPTPATH/config_export.sh "$FULLPATH" "$ENVIRONMENT"
