### Use Cases Jobs & Cron Jobs
- DB Backups
- Log Rotations
- Data Processing ...


### Key Differences
| Feature      | Job                              | CronJob                           |
|--------------|----------------------------------|-----------------------------------|
| Purpose      | Executes once and terminates     | Executes on a schedule            |
| Use Case     | Data migration, file processing  | Automated backups, periodic monitoring |
| Trigger      | Manually or programmatically invoked | Scheduled based on a time interval |
| Examples     | Compressing logs, importing data | Backups, sending periodic emails  |

### Commands to Manage Jobs and CronJobs

Create a Job or CronJob:
```bash
kubectl apply -f job.yaml
kubectl apply -f cronjob.yaml
```

Check Job/CronJob Status:
```bash
kubectl get jobs
kubectl get cronjobs
```

Inspect Job Logs:
```bash
kubectl logs <pod-name>
```
Delete a Job or CronJob:
```bash
kubectl delete job compress-logs
kubectl delete cronjob daily-db-backup
```