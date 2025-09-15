# Log Management for DevOps

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Use journalctl to view and manage system logs
- Configure log rotation with logrotate
- Analyze application logs for troubleshooting
- Set up centralized logging
- Monitor log files in real-time

## 📋 Why Log Management Matters in DevOps

Log management is essential for:
- **Troubleshooting**: Diagnose application and system issues
- **Monitoring**: Track system performance and errors
- **Security**: Detect security breaches and anomalies
- **Compliance**: Meet audit and regulatory requirements
- **Debugging**: Understand application behavior

## 📊 System Logs with journalctl

### Basic journalctl Usage
```bash
# View all logs
sudo journalctl

# View logs with timestamps
sudo journalctl -t

# View logs from today
sudo journalctl --since today

# View logs from specific time
sudo journalctl --since "2024-01-15 10:00:00"

# View logs from last hour
sudo journalctl --since "1 hour ago"

# View logs from specific service
sudo journalctl -u nginx
sudo journalctl -u mysql

# Follow logs in real-time
sudo journalctl -f

# View logs with priority levels
sudo journalctl -p err
sudo journalctl -p warning
```

### Advanced journalctl Options
```bash
# View logs with specific fields
sudo journalctl -o verbose

# View logs in JSON format
sudo journalctl -o json

# View logs from specific user
sudo journalctl _UID=1000

# View logs from specific process
sudo journalctl _PID=1234

# View logs with specific executable
sudo journalctl /usr/bin/nginx

# Export logs to file
sudo journalctl --since "1 week ago" > system_logs.txt

# View logs with specific boot
sudo journalctl -b
sudo journalctl -b -1  # Previous boot
```

## 🔄 Log Rotation with logrotate

### logrotate Configuration
```bash
# Main configuration file
sudo nano /etc/logrotate.conf

# Custom logrotate configurations
sudo nano /etc/logrotate.d/myapp

# Example configuration:
# /var/log/myapp/*.log {
#     daily
#     missingok
#     rotate 7
#     compress
#     delaycompress
#     notifempty
#     create 644 myapp myapp
#     postrotate
#         systemctl reload myapp
#     endscript
# }
```

### logrotate Options
```bash
# Test logrotate configuration
sudo logrotate -d /etc/logrotate.conf

# Force log rotation
sudo logrotate -f /etc/logrotate.conf

# View logrotate status
sudo cat /var/lib/logrotate/status

# Check specific log file rotation
sudo logrotate -d /etc/logrotate.d/nginx
```

## 📝 Hands-on Exercises

### Exercise 1: System Log Analysis
```bash
# View system boot logs
sudo journalctl -b

# Check for errors in the last hour
sudo journalctl --since "1 hour ago" -p err

# View nginx logs
sudo journalctl -u nginx --since today

# Follow system logs in real-time
sudo journalctl -f

# Search for specific error messages
sudo journalctl | grep -i "error\|failed\|critical"
```

### Exercise 2: Log Rotation Setup
```bash
# Create sample log file
sudo mkdir -p /var/log/myapp
sudo touch /var/log/myapp/application.log

# Create logrotate configuration
sudo tee /etc/logrotate.d/myapp > /dev/null << EOF
/var/log/myapp/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 644 myapp myapp
    postrotate
        echo "Log rotated at \$(date)" >> /var/log/myapp/application.log
    endscript
}
EOF

# Test logrotate configuration
sudo logrotate -d /etc/logrotate.d/myapp

# Force log rotation
sudo logrotate -f /etc/logrotate.d/myapp
```

### Exercise 3: Log Monitoring Script
```bash
# Create log monitoring script
cat > ~/log_monitor.sh << 'EOF'
#!/bin/bash
LOG_FILE="/var/log/myapp/application.log"
ALERT_EMAIL="admin@example.com"

# Monitor for errors
tail -f "$LOG_FILE" | while read line; do
    if echo "$line" | grep -qi "error\|exception\|critical"; then
        echo "ALERT: $line" | mail -s "Log Alert" "$ALERT_EMAIL"
        echo "[$(date)] ALERT: $line" >> /var/log/log_monitor.log
    fi
done
EOF

chmod +x ~/log_monitor.sh

# Test the script
echo "This is an error message" | sudo tee -a /var/log/myapp/application.log
```

## 🎯 DevOps Scenarios

### Scenario 1: Application Log Management
```bash
#!/bin/bash
# setup_application_logging.sh

echo "Setting up application logging..."

# Create application log directory
sudo mkdir -p /var/log/myapp
sudo chown myapp:myapp /var/log/myapp

# Create logrotate configuration
sudo tee /etc/logrotate.d/myapp > /dev/null << EOF
/var/log/myapp/*.log {
    daily
    missingok
    rotate 30
    compress
    delaycompress
    notifempty
    create 644 myapp myapp
    postrotate
        systemctl reload myapp
    endscript
}

/var/log/myapp/*.err {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 644 myapp myapp
}
EOF

# Create log monitoring script
sudo tee /opt/scripts/log_monitor.sh > /dev/null << 'EOF'
#!/bin/bash
LOG_FILE="/var/log/myapp/application.log"
ERROR_LOG="/var/log/myapp/errors.log"
ALERT_EMAIL="admin@example.com"

# Monitor logs for errors
tail -f "$LOG_FILE" | while read line; do
    if echo "$line" | grep -qi "error\|exception\|critical\|fatal"; then
        echo "$line" >> "$ERROR_LOG"
        echo "ALERT: $line" | mail -s "Application Error Alert" "$ALERT_EMAIL"
    fi
done
EOF

sudo chmod +x /opt/scripts/log_monitor.sh

# Create systemd service for log monitoring
sudo tee /etc/systemd/system/log-monitor.service > /dev/null << EOF
[Unit]
Description=Log Monitor Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/scripts/log_monitor.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Enable and start log monitor
sudo systemctl daemon-reload
sudo systemctl enable log-monitor
sudo systemctl start log-monitor

echo "✅ Application logging configured!"
```

### Scenario 2: Centralized Log Collection
```bash
#!/bin/bash
# setup_centralized_logging.sh

echo "Setting up centralized logging..."

# Install rsyslog
sudo apt update
sudo apt install -y rsyslog

# Configure rsyslog for centralized logging
sudo tee -a /etc/rsyslog.conf > /dev/null << EOF

# Forward all logs to central server
*.* @@central-log-server:514

# Local logging rules
local0.*    /var/log/myapp/application.log
local1.*    /var/log/myapp/errors.log
local2.*    /var/log/myapp/access.log
EOF

# Create log forwarding script
sudo tee /opt/scripts/log_forwarder.sh > /dev/null << 'EOF'
#!/bin/bash
CENTRAL_SERVER="central-log-server"
CENTRAL_PORT="514"

# Forward application logs
tail -f /var/log/myapp/application.log | while read line; do
    echo "<14>$(date '+%b %d %H:%M:%S') $(hostname) myapp: $line" | \
        nc -w1 "$CENTRAL_SERVER" "$CENTRAL_PORT"
done
EOF

sudo chmod +x /opt/scripts/log_forwarder.sh

# Restart rsyslog
sudo systemctl restart rsyslog

echo "✅ Centralized logging configured!"
```

### Scenario 3: Log Analysis and Reporting
```bash
#!/bin/bash
# setup_log_analysis.sh

echo "Setting up log analysis..."

# Create log analysis script
sudo tee /opt/scripts/log_analyzer.sh > /dev/null << 'EOF'
#!/bin/bash
LOG_FILE="/var/log/myapp/application.log"
REPORT_FILE="/var/log/myapp/daily_report.txt"
DATE=$(date '+%Y-%m-%d')

echo "=== Daily Log Report - $DATE ===" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Count log entries by level
echo "Log Level Summary:" >> "$REPORT_FILE"
grep -c "INFO" "$LOG_FILE" | awk '{print "INFO: " $1}' >> "$REPORT_FILE"
grep -c "WARN" "$LOG_FILE" | awk '{print "WARN: " $1}' >> "$REPORT_FILE"
grep -c "ERROR" "$LOG_FILE" | awk '{print "ERROR: " $1}' >> "$REPORT_FILE"
grep -c "CRITICAL" "$LOG_FILE" | awk '{print "CRITICAL: " $1}' >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# Top error messages
echo "Top Error Messages:" >> "$REPORT_FILE"
grep "ERROR" "$LOG_FILE" | sort | uniq -c | sort -nr | head -10 >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# Response time analysis
echo "Response Time Analysis:" >> "$REPORT_FILE"
grep "response_time" "$LOG_FILE" | awk '{print $NF}' | sort -n | \
    awk 'BEGIN{count=0; sum=0} {count++; sum+=$1} END{print "Average: " sum/count "ms"}' >> "$REPORT_FILE"

# Send report via email
mail -s "Daily Log Report - $DATE" admin@example.com < "$REPORT_FILE"
EOF

sudo chmod +x /opt/scripts/log_analyzer.sh

# Create systemd service for daily reports
sudo tee /etc/systemd/system/log-analyzer.service > /dev/null << EOF
[Unit]
Description=Daily Log Analysis
After=network.target

[Service]
Type=oneshot
ExecStart=/opt/scripts/log_analyzer.sh
StandardOutput=journal
StandardError=journal
EOF

# Create timer for daily reports
sudo tee /etc/systemd/system/log-analyzer.timer > /dev/null << EOF
[Unit]
Description=Daily Log Analysis Timer
Requires=log-analyzer.service

[Timer]
OnCalendar=daily
OnCalendar=*-*-* 23:59:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable log-analyzer.timer
sudo systemctl start log-analyzer.timer

echo "✅ Log analysis configured!"
```

## 🔍 Log Analysis Tools

### grep and awk for Log Analysis
```bash
# Find error patterns
grep -i "error\|exception\|critical" /var/log/myapp/application.log

# Count error occurrences
grep -c "ERROR" /var/log/myapp/application.log

# Extract specific fields
awk '{print $1, $2, $NF}' /var/log/myapp/application.log

# Analyze response times
grep "response_time" /var/log/myapp/application.log | awk '{print $NF}' | sort -n

# Find unique error messages
grep "ERROR" /var/log/myapp/application.log | sort | uniq -c | sort -nr
```

### Real-time Log Monitoring
```bash
# Monitor multiple log files
tail -f /var/log/myapp/*.log

# Monitor with filtering
tail -f /var/log/myapp/application.log | grep -i "error\|warning"

# Monitor with timestamps
tail -f /var/log/myapp/application.log | while read line; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') $line"
done
```

## 💡 Best Practices

1. **Structured Logging**: Use consistent log formats
2. **Log Levels**: Use appropriate log levels (DEBUG, INFO, WARN, ERROR, CRITICAL)
3. **Rotation**: Implement log rotation to prevent disk space issues
4. **Monitoring**: Set up alerts for critical errors
5. **Retention**: Define log retention policies

## ✅ Check Your Understanding

1. How do you view logs from a specific service?
2. What's the purpose of log rotation?
3. How do you monitor logs in real-time?
4. How do you analyze log files for errors?
5. What are the benefits of centralized logging?

## 🚀 Next Steps

Ready to learn about disk management? Move on to [Disk Management](../disk-management/) to understand storage management for containers and applications.

---

> **💡 Remember**: Effective log management is crucial for troubleshooting and monitoring. Master these tools for better system observability!
