#!/usr/bin/env bash
set -Eeuo pipefail
REGION="us-west1"
gcloud database-migration migration-jobs promote vm-to-cloudsql --region="$REGION"
gcloud database-migration migration-jobs describe vm-to-cloudsql --region="$REGION" --format='yaml(name,state)' || true
echo 'Task 6 complete when the migration job state is COMPLETED and mysql-cloudsql is standalone.'
