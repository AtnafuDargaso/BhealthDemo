#!/bin/bash
# Initialize all environments for Terraform
set -e
for env in dev staging prod; do
  echo "Initializing $env..."
  cd $(dirname "$0")/../envs/$env
  terraform init
  cd - > /dev/null
  echo "Done with $env."
done
