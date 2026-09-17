#!/usr/bin/env bash
set -Eeuo pipefail
REGION="us-west1"
SOURCE_PROFILE="mysql-vm"
DEST_PROFILE="${DEST_PROFILE:-mysql-cloudsql}"
gcloud database-migration connection-profiles describe "$SOURCE_PROFILE" --region="$REGION" >/dev/null || { echo 'Run Task 2 first.' >&2; exit 1; }
if ! gcloud database-migration connection-profiles describe "$DEST_PROFILE" --region="$REGION" >/dev/null 2>&1; then
  echo "Destination profile '$DEST_PROFILE' was not found. Use the DMS console wizard for Task 2: select existing mysql-cloudsql, choose VPC peering/default VPC, then Test Job and Create & start job." >&2
  exit 2
fi
if ! gcloud database-migration migration-jobs describe vm-to-cloudsql --region="$REGION" >/dev/null 2>&1; then
  gcloud database-migration migration-jobs create vm-to-cloudsql --region="$REGION" --type=CONTINUOUS --source="$SOURCE_PROFILE" --destination="$DEST_PROFILE" --peer-vpc="projects/$(gcloud config get-value project)/global/networks/default" --no-async
fi
gcloud database-migration migration-jobs start vm-to-cloudsql --region="$REGION" --no-async 2>/dev/null || true
gcloud database-migration migration-jobs describe vm-to-cloudsql --region="$REGION"
echo 'Task 3 complete when the job status reaches RUNNING.'
