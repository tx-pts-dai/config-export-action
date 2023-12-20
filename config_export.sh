#!/bin/bash
config_path=$0
if [ ! -f $config_path ]; then
  echo "Config file not found at $config_path"
  exit 1
fi
environment=$1

config=$(yq -r -o=json '.environment' $config_path | jq -rc)
matrix=$(yq -r -o=json '.environment | to_entries | map({"environment": .key} + .value)' $config_path | jq -rc)
echo "config=$config" >> $GITHUB_OUTPUT
echo "matrix=$matrix" >> $GITHUB_OUTPUT

# Set defaults
tf_dir=$(yq -r -o=json '.defaults.tf_dir' $config_path)
echo "tf_dir=$tf_dir" >> $GITHUB_OUTPUT

if [ $environment ]; then
  aws_account_id=$(yq -r -o=json '.environment.'"$environment"'.aws_account_id' $config_path)
  aws_region=$(yq -r -o=json '.environment.${{ inputs.environment }}.aws_region' $config_path)
  aws_role_name=$(yq -r -o=json '.environment.${{ inputs.environment }}.aws_role_name' $config_path)
  tf_state_bucket=$(yq -r -o=json '.environment.${{ inputs.environment }}.tf_state_bucket' $config_path)
  tf_state_key=$(yq -r -o=json '.environment.${{ inputs.environment }}.tf_state_key' $config_path)
  tf_dir=$(yq -r -o=json '.environment.${{ inputs.environment }}.tf_dir' $config_path)
  echo "aws_account_id=$aws_account_id" >> $GITHUB_OUTPUT
  echo "aws_region=$aws_region" >> $GITHUB_OUTPUT
  echo "aws_role_name=$aws_role_name" >> $GITHUB_OUTPUT
  echo "tf_state_bucket=$tf_state_bucket" >> $GITHUB_OUTPUT
  echo "tf_state_key=$tf_state_key" >> $GITHUB_OUTPUT
  echo "tf_dir=$tf_dir" >> $GITHUB_OUTPUT
fi

cat $GITHUB_OUTPUT