#!/usr/bin/env bash
set -Eeuo pipefail
PROJECT_ID="$(gcloud config get-value project)"
ZONE="us-west1-b"
VM="dms-mysql-training-vm-v2"
gcloud compute ssh "$VM" --zone="$ZONE" --quiet --command="mysql -u admin -pchangeme -e \"USE customers_data; INSERT INTO customers (customerKey,addressKey,title,firstName,lastName,birthdate,gender,maritalStatus,email,creationDate) VALUES ('9365552000000-999','9999999','Ms','Magna','Ablorem','1953-07-28 00:00:00','FEMALE','MARRIED','magna.lorem@gmail.com',CURRENT_TIMESTAMP),('9965552000000-9999','99999999','Mr','Arcu','Abrisus','1959-07-28 00:00:00','MALE','MARRIED','arcu.risus@gmail.com',CURRENT_TIMESTAMP); SELECT COUNT(*) FROM customers;\""
echo 'Source update submitted. Wait for the continuous job to apply the changes, then run:'
echo 'gcloud sql connect mysql-cloudsql --user=root --quiet'
echo 'In MySQL: use customers_data; select count(*) from customers;'
echo 'Expected count after replication: 5032'
