#!/usr/bin/env bash

# Exit immediately when a command fails.
set -e

echo "=============================="
echo "1. Running SAST"
echo "=============================="

bandit -r app -ll


echo "=============================="
echo "2. Scanning Infrastructure"
echo "=============================="

checkov -d infra


echo "=============================="
echo "3. Scanning Dependencies,"
echo "   Secrets and Configurations"
echo "=============================="

trivy fs \
  --scanners vuln,secret,misconfig \
  --severity HIGH,CRITICAL \
  --exit-code 1 \
  .


echo "=============================="
echo "Security checks passed."
echo "=============================="