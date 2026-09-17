#!/usr/bin/env bash
set -Eeuo pipefail
export PROJECT_ID="$(gcloud config get-value project)"
export REGION="us-west1"
SOURCE_IP="${SOURCE_IP:-$(cat "$HOME/gsp860-source-ip.txt" 2>/dev/null || true)}"
[[ -n "$SOURCE_IP" ]] || { echo 'Run Task 1 first, or set SOURCE_IP=10.x.x.x.' >&2; exit 1; }
if ! gcloud database-migration connection-profiles describe mysql-vm --region="$REGION" >/dev/null 2>&1; then
  gcloud database-migration connection-profiles create mysql mysql-vm \
    --region="$REGION" --display-name='mysql-vm' \
    --host="$SOURCE_IP" --port=3306 --username=admin --password=changeme \
    --ssl-type=NONE --no-async
else
  echo 'mysql-vm connection profile already exists; reusing it.'
fi
echo 'Task 2 source profile complete. In the DMS wizard, select mysql-vm and continue with existing destination mysql-cloudsql and VPC peering.'
