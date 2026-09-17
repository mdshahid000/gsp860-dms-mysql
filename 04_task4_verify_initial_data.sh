#!/usr/bin/env bash
set -Eeuo pipefail
INSTANCE="mysql-cloudsql"
DB_IP="$(gcloud sql instances describe "$INSTANCE" --format='value(ipAddresses[0].ipAddress)')"
command -v mysql >/dev/null 2>&1 || { echo 'mysql client is unavailable. Run: gcloud sql connect mysql-cloudsql --user=root --quiet'; exit 1; }
for i in {1..12}; do
  if MYSQL_PWD='supersecret!' mysql --connect-timeout=10 -h "$DB_IP" -u root -e 'USE customers_data; SELECT COUNT(*) AS customer_count FROM customers; SELECT * FROM customers ORDER BY lastName LIMIT 10;' 2>/tmp/gsp860-mysql.err; then
    echo 'Task 4 complete. Migrated data is present in Cloud SQL.'; exit 0
  fi
  echo "Waiting for Cloud SQL migration data ($i/12)..."; sleep 15
done
cat /tmp/gsp860-mysql.err >&2
exit 1
