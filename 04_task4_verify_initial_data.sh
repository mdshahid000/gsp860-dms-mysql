#!/usr/bin/env bash
set -Eeuo pipefail
INSTANCE="mysql-cloudsql"
echo 'Run the following command and enter the lab password supersecret! when prompted:'
echo "gcloud sql connect $INSTANCE --user=root --quiet"
echo 'Then run these SQL statements in the MySQL console:'
printf '%s\n' 'use customers_data;' 'select count(*) from customers;' 'select * from customers order by lastName limit 10;' 'exit'
echo 'Task 4 verification commands displayed.'
