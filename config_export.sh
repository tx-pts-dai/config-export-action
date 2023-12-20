#!/bin/bash
set -e
config_path=$1
if [ ! -f $config_path ]; then
  echo "Aborting Script: Config file not found at $config_path"
  exit 1
fi
environment=$2

echo config=$(yq -r -o=json '.environment' $config_path | jq -rc) >> $GITHUB_OUTPUT
# Convert environments to list that can be used for matrix builds
echo matrix=$(yq -r -o=json '.environment | to_entries | map({"environment": .key} + .value)' $config_path | jq -rc) >> $GITHUB_OUTPUT

# Set defaults
defaults=$(yq '.defaults' $config_path)
if [ "$defaults" != "null" ]; then
  for key in $(yq ".defaults | keys" $config_path); do
    value=$(yq ".defaults.$key" $config_path)
    echo $key=$value >> $GITHUB_OUTPUT
  done
fi

if [ $environment ]; then
  for key in $(yq ".environment.$environment | keys" $config_path); do
    value=$(yq ".environment.$environment.$key" $config_path)
    echo $key=$value >> $GITHUB_OUTPUT
  done
fi
