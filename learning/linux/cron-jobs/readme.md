# Cron Jobs and Task Scheduling

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Create and manage cron jobs
- Understand cron syntax and scheduling
- Use systemd timers for modern task scheduling
- Monitor and troubleshoot scheduled tasks
- Implement automated DevOps workflows

## ⏰ Why Task Scheduling Matters in DevOps

Task scheduling is essential for:
- **Automated Backups**: Regular data backups
- **Monitoring**: Health checks and alerts
- **Maintenance**: System cleanup and updates
- **Deployments**: Automated application deployments
- **Reporting**: Generate regular reports

## 🕐 Cron Jobs

### Cron Syntax
```bash
# Cron format: minute hour day month weekday command
# * * * * * command
# │ │ │ │ │
# │ │ │ │ └─── Day of week (0-7, 0 and 7 = Sunday)
# │ │ │ └───── Month (1-12)
# │ │ └─────── Day of month (1-31)
# │ └───────── Hour (0-23)
# └─────────── Minute (0-59)

# Examples:
0 2 * * * /path/to/backup.sh          # Daily at 2:00 AM
*/15 * * * * /path/to/monitor.sh      # Every 15 minutes
0 0 1 * * /path/to/monthly-report.sh  # Monthly on 1st at midnight
0 9 * * 1-5 /path/to/daily-task.sh    # Weekdays at 9:00 AM
```

### Managing Cron Jobs
```bash
# Edit user's crontab
crontab -e

# List user's crontab
crontab -l

# Remove user's crontab
crontab -r

# Edit another user's crontab (requires sudo)
sudo crontab -e -u username

# List system-wide crontab
sudo crontab -l

# View cron logs
sudo tail -f /var/log/cron
sudo journalctl -u cron
```

### System-wide Cron Jobs
```bash
# System crontab locations:
# /etc/crontab - System-wide crontab
# /etc/cron.d/ - Custom cron files
# /etc/cron.hourly/ - Hourly scripts
# /etc/cron.daily/ - Daily scripts
# /etc/cron.weekly/ - Weekly scripts
# /etc/cron.monthly/ - Monthly scripts

# Create custom cron file
sudo tee /etc/cron.d/myapp << EOF
# Run backup every 6 hours
0 */6 * * * root /opt/myapp/backup.sh

# Run health check every 5 minutes
*/5 * * * * root /opt/myapp/health-check.sh
EOF
```

## ⚡ Systemd Timers

### Creating Systemd Timers
```bash
# Create service file
sudo tee /etc/systemd/system/backup.service > /dev/null << EOF
[Unit]
Description=Database Backup
After=network.target

[Service]
Type=oneshot
User=backup
ExecStart=/opt/scripts/backup.sh
StandardOutput=journal
StandardError=journal
EOF

# Create timer file
sudo tee /etc/systemd/system/backup.timer > /dev/null << EOF
[Unit]
Description=Run backup every 6 hours
Requires=backup.service

[Timer]
OnCalendar=*-*-* 00,06,12,18:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start timer
sudo systemctl daemon-reload
sudo systemctl enable backup.timer
sudo systemctl start backup.timer

# Check timer status
sudo systemctl status backup.timer
sudo systemctl list-timers
```

### Timer Examples
```bash
# Run every 15 minutes
OnCalendar=*:0/15

# Run daily at 2:00 AM
OnCalendar=daily
OnCalendar=*-*-* 02:00:00

# Run weekly on Monday at 9:00 AM
OnCalendar=weekly
OnCalendar=Mon 09:00:00

# Run monthly on 1st at midnight
OnCalendar=monthly
OnCalendar=*-*-01 00:00:00
```

## 📝 Hands-on Exercises

### Exercise 1: Basic Cron Job
```bash
# Create a simple backup script
cat > ~/backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/tmp/backups"
mkdir -p "$BACKUP_DIR"
echo "Backup created at $(date)" > "$BACKUP_DIR/backup_$DATE.txt"
echo "Backup completed: backup_$DATE.txt"
EOF

chmod +x ~/backup.sh

# Test the script
~/backup.sh

# Add to crontab (run every hour)
crontab -e
# Add this line: 0 * * * * /home/username/backup.sh

# Verify crontab
crontab -l
```

### Exercise 2: System Monitoring Cron Job
```bash
# Create system monitoring script
cat > ~/system_monitor.sh << 'EOF'
#!/bin/bash
LOG_FILE="/tmp/system_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] System Status:" >> "$LOG_FILE"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')" >> "$LOG_FILE"
echo "Memory Usage: $(free | awk '/^Mem:/ {printf "%.1f%%\n", $3/$2*100}')" >> "$LOG_FILE"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $5}')" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"
EOF

chmod +x ~/system_monitor.sh

# Test the script
~/system_monitor.sh
cat /tmp/system_monitor.log

# Schedule to run every 5 minutes
crontab -e
# Add: */5 * * * * /home/username/system_monitor.sh
```

### Exercise 3: Systemd Timer
```bash
# Create a log cleanup service
sudo tee /etc/systemd/system/log-cleanup.service > /dev/null << EOF
[Unit]
Description=Log Cleanup Service
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'find /var/log -name "*.log" -mtime +7 -delete'
StandardOutput=journal
StandardError=journal
EOF

# Create timer for weekly cleanup
sudo tee /etc/systemd/system/log-cleanup.timer > /dev/null << EOF
[Unit]
Description=Weekly Log Cleanup
Requires=log-cleanup.service

[Timer]
OnCalendar=weekly
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable log-cleanup.timer
sudo systemctl start log-cleanup.timer

# Check status
sudo systemctl status log-cleanup.timer
sudo systemctl list-timers | grep log-cleanup
```

## 🎯 DevOps Scenarios

### Scenario 1: Automated Backup System
```bash
#!/bin/bash
# setup_automated_backup.sh

echo "Setting up automated backup system..."

# Create backup script
sudo tee /opt/scripts/backup.sh > /dev/null << 'EOF'
#!/bin/bash
BACKUP_DIR="/opt/backups"
DATE=$(date +%Y%m%d_%H%M%S)
LOG_FILE="/var/log/backup.log"

echo "[$(date)] Starting backup..." >> "$LOG_FILE"

# Create backup directory
mkdir -p "$BACKUP_DIR/$DATE"

# Backup application data
tar -czf "$BACKUP_DIR/$DATE/app_data.tar.gz" /opt/myapp/data/

# Backup configuration files
tar -czf "$BACKUP_DIR/$DATE/config.tar.gz" /etc/myapp/

# Backup database
mysqldump -u backup_user -p'password' myapp > "$BACKUP_DIR/$DATE/database.sql"

# Remove backups older than 30 days
find "$BACKUP_DIR" -type d -mtime +30 -exec rm -rf {} \;

echo "[$(date)] Backup completed successfully" >> "$LOG_FILE"
EOF

sudo chmod +x /opt/scripts/backup.sh

# Create systemd service
sudo tee /etc/systemd/system/backup.service > /dev/null << EOF
[Unit]
Description=Automated Backup Service
After=network.target

[Service]
Type=oneshot
ExecStart=/opt/scripts/backup.sh
StandardOutput=journal
StandardError=journal
EOF

# Create timer (daily at 2 AM)
sudo tee /etc/systemd/system/backup.timer > /dev/null << EOF
[Unit]
Description=Daily Backup Timer
Requires=backup.service

[Timer]
OnCalendar=daily
OnCalendar=*-*-* 02:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable backup.timer
sudo systemctl start backup.timer

echo "✅ Automated backup system configured!"
```

### Scenario 2: Health Check Automation
```bash
#!/bin/bash
# setup_health_checks.sh

echo "Setting up health check automation..."

# Create health check script
sudo tee /opt/scripts/health_check.sh > /dev/null << 'EOF'
#!/bin/bash
LOG_FILE="/var/log/health_check.log"
ALERT_EMAIL="admin@example.com"

check_service() {
    local service="$1"
    if systemctl is-active --quiet "$service"; then
        echo "[$(date)] ✅ $service is running" >> "$LOG_FILE"
        return 0
    else
        echo "[$(date)] ❌ $service is not running" >> "$LOG_FILE"
        # Send alert
        echo "Service $service is down on $(hostname)" | mail -s "Service Alert" "$ALERT_EMAIL"
        return 1
    fi
}

# Check critical services
check_service "nginx"
check_service "mysql"
check_service "redis"

# Check disk space
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [[ $DISK_USAGE -gt 80 ]]; then
    echo "[$(date)] ⚠️  Disk usage is ${DISK_USAGE}%" >> "$LOG_FILE"
    echo "Disk usage is ${DISK_USAGE}% on $(hostname)" | mail -s "Disk Space Alert" "$ALERT_EMAIL"
fi

# Check memory usage
MEMORY_USAGE=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2*100}')
if [[ $MEMORY_USAGE -gt 90 ]]; then
    echo "[$(date)] ⚠️  Memory usage is ${MEMORY_USAGE}%" >> "$LOG_FILE"
    echo "Memory usage is ${MEMORY_USAGE}% on $(hostname)" | mail -s "Memory Alert" "$ALERT_EMAIL"
fi
EOF

sudo chmod +x /opt/scripts/health_check.sh

# Create systemd service
sudo tee /etc/systemd/system/health-check.service > /dev/null << EOF
[Unit]
Description=Health Check Service
After=network.target

[Service]
Type=oneshot
ExecStart=/opt/scripts/health_check.sh
StandardOutput=journal
StandardError=journal
EOF

# Create timer (every 5 minutes)
sudo tee /etc/systemd/system/health-check.timer > /dev/null << EOF
[Unit]
Description=Health Check Timer
Requires=health-check.service

[Timer]
OnCalendar=*:0/5
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable health-check.timer
sudo systemctl start health-check.timer

echo "✅ Health check automation configured!"
```

### Scenario 3: Log Rotation and Cleanup
```bash
#!/bin/bash
# setup_log_management.sh

echo "Setting up log management..."

# Create log cleanup script
sudo tee /opt/scripts/log_cleanup.sh > /dev/null << 'EOF'
#!/bin/bash
LOG_DIR="/var/log"
RETENTION_DAYS=30

echo "[$(date)] Starting log cleanup..." >> /var/log/log_cleanup.log

# Clean old log files
find "$LOG_DIR" -name "*.log" -mtime +$RETENTION_DAYS -delete
find "$LOG_DIR" -name "*.log.*" -mtime +$RETENTION_DAYS -delete

# Clean old journal logs
journalctl --vacuum-time=${RETENTION_DAYS}d

# Clean old backups
find /opt/backups -type f -mtime +$RETENTION_DAYS -delete

echo "[$(date)] Log cleanup completed" >> /var/log/log_cleanup.log
EOF

sudo chmod +x /opt/scripts/log_cleanup.sh

# Create systemd service
sudo tee /etc/systemd/system/log-cleanup.service > /dev/null << EOF
[Unit]
Description=Log Cleanup Service
After=network.target

[Service]
Type=oneshot
ExecStart=/opt/scripts/log_cleanup.sh
StandardOutput=journal
StandardError=journal
EOF

# Create timer (weekly)
sudo tee /etc/systemd/system/log-cleanup.timer > /dev/null << EOF
[Unit]
Description=Weekly Log Cleanup
Requires=log-cleanup.service

[Timer]
OnCalendar=weekly
OnCalendar=Mon 03:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable log-cleanup.timer
sudo systemctl start log-cleanup.timer

echo "✅ Log management configured!"
```

## 🔧 Monitoring and Troubleshooting

### Monitoring Cron Jobs
```bash
# Check cron service status
sudo systemctl status cron

# View cron logs
sudo tail -f /var/log/cron
sudo journalctl -u cron -f

# Check systemd timers
sudo systemctl list-timers
sudo systemctl status timer-name.timer

# View timer logs
sudo journalctl -u timer-name.service
```

### Troubleshooting Common Issues
```bash
# Check if cron is running
sudo systemctl status cron

# Check cron syntax
crontab -l | grep -v '^#' | while read line; do
    echo "Testing: $line"
    # Test cron syntax online or with tools
done

# Check file permissions
ls -la /opt/scripts/backup.sh

# Check environment variables
# Cron jobs run with minimal environment
# Use absolute paths in scripts
```

## 💡 Best Practices

1. **Use Absolute Paths**: Always use full paths in cron jobs
2. **Log Output**: Redirect output to log files
3. **Test Scripts**: Test scripts manually before scheduling
4. **Monitor Execution**: Set up monitoring for critical jobs
5. **Documentation**: Document all scheduled tasks

## ✅ Check Your Understanding

1. How do you schedule a job to run every 15 minutes?
2. What's the difference between cron and systemd timers?
3. How do you check if a cron job is running?
4. How do you troubleshoot a failed cron job?
5. What are the benefits of systemd timers over cron?

## 🚀 Next Steps

Ready to learn about log management? Move on to [Log Management](../log-management/) to understand system logging and log analysis.

---

> **💡 Remember**: Task scheduling is the backbone of automation. Master these tools for efficient DevOps operations!
