#!/usr/bin/env bash
set -Eeuo pipefail
export PROJECT_ID="$(gcloud config get-value project)"
export REGION="us-west1"
export ZONE="us-west1-b"
gcloud config set compute/region "$REGION" >/dev/null
gcloud config set compute/zone "$ZONE" >/dev/null
gcloud services enable datamigration.googleapis.com servicenetworking.googleapis.com sqladmin.googleapis.com compute.googleapis.com
gcloud compute instances describe dms-mysql-training-vm-v2 --zone="$ZONE" --format='value(networkInterfaces[0].networkIP)' | tee "$HOME/gsp860-source-ip.txt"
echo 'Task 1 complete. The source internal IP is saved in ~/gsp860-source-ip.txt.'
