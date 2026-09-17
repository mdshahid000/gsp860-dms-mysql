# GSP860 — Migrating On-premises MySQL Using a Continuous DMS Job

Each lab task has its own script. Run them in order in Cloud Shell.

```bash
curl -fsSLO https://raw.githubusercontent.com/mdshahid000/gsp860-dms-mysql/master/01_task1_enable_and_get_ip.sh && chmod +x 01_task1_enable_and_get_ip.sh && ./01_task1_enable_and_get_ip.sh
curl -fsSLO https://raw.githubusercontent.com/mdshahid000/gsp860-dms-mysql/master/02_task2_create_source_profile.sh && chmod +x 02_task2_create_source_profile.sh && ./02_task2_create_source_profile.sh
curl -fsSLO https://raw.githubusercontent.com/mdshahid000/gsp860-dms-mysql/master/03_task3_create_start_review_job.sh && chmod +x 03_task3_create_start_review_job.sh && ./03_task3_create_start_review_job.sh
curl -fsSLO https://raw.githubusercontent.com/mdshahid000/gsp860-dms-mysql/master/04_task4_verify_initial_data.sh && chmod +x 04_task4_verify_initial_data.sh && ./04_task4_verify_initial_data.sh
curl -fsSLO https://raw.githubusercontent.com/mdshahid000/gsp860-dms-mysql/master/05_task5_test_continuous_migration.sh && chmod +x 05_task5_test_continuous_migration.sh && ./05_task5_test_continuous_migration.sh
curl -fsSLO https://raw.githubusercontent.com/mdshahid000/gsp860-dms-mysql/master/06_task6_promote_cloudsql.sh && chmod +x 06_task6_promote_cloudsql.sh && ./06_task6_promote_cloudsql.sh
```

Task 1 enables APIs and records the source VM internal IP. Task 2 creates the `mysql-vm` source connection profile. The DMS console wizard is intentionally required for the destination step because the lab says to select the supplied existing `mysql-cloudsql` instance; automatically creating a new Cloud SQL destination would be outside the lab scope. After selecting that instance, choose VPC peering with the default VPC, test, and create/start the job. Task 3 can start/review the job when the destination profile ID is available as `DEST_PROFILE`.

Task 4 prints the exact SQL verification commands. Task 5 inserts the two required records on the source VM and prints the destination verification command. Task 6 promotes the migration job.

Expected time is approximately 25–45 minutes, depending on DMS initial dump and replication. Do not commit the generated service-account key; it remains only in Cloud Shell.
