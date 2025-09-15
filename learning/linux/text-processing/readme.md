# Text Processing for DevOps

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Use grep for log analysis and pattern matching
- Process text with sed for configuration file manipulation
- Extract data with awk for monitoring and reporting
- Combine tools for complex DevOps workflows

## 🔍 Why Text Processing Matters in DevOps

Text processing is crucial for:
- **Log Analysis**: Finding errors, patterns, and trends
- **Configuration Management**: Modifying config files programmatically
- **Monitoring**: Extracting metrics from system output
- **Automation**: Processing data in scripts and pipelines

## 🔎 grep - Pattern Matching

### Basic Usage:
```bash
# Search for text in files
grep "error" /var/log/syslog

# Case-insensitive search
grep -i "ERROR" /var/log/syslog

# Show line numbers
grep -n "error" /var/log/syslog

# Show context (lines before/after)
grep -C 3 "error" /var/log/syslog

# Count matches
grep -c "error" /var/log/syslog

# Show only filenames with matches
grep -l "error" /var/log/*
```

### Advanced grep:
```bash
# Regular expressions
grep -E "error|warning|critical" /var/log/syslog

# Invert match (show lines that DON'T match)
grep -v "debug" /var/log/syslog

# Search in all files recursively
grep -r "database" /var/log/

# Show only matching text
grep -o "error [0-9]*" /var/log/syslog
```

## 🔧 sed - Stream Editor

### Basic Substitution:
```bash
# Replace first occurrence per line
sed 's/old/new/' file.txt

# Replace all occurrences
sed 's/old/new/g' file.txt

# Replace only on specific lines
sed '5s/old/new/' file.txt

# Replace in range of lines
sed '1,10s/old/new/' file.txt
```

### DevOps Examples:
```bash
# Update configuration files
sed -i 's/server_name old.example.com;/server_name new.example.com;/' nginx.conf

# Remove commented lines
sed '/^#/d' config.conf

# Add timestamp to logs
echo "log entry" | sed "s/^/$(date '+%Y-%m-%d %H:%M:%S') /"

# Extract specific fields
sed -n 's/.*user=\([^ ]*\).*/\1/p' access.log
```

## ⚡ awk - Pattern Processing

### Basic Structure:
```bash
# Print specific fields
awk '{print $1, $3}' file.txt

# Use field separator
awk -F: '{print $1, $5}' /etc/passwd

# Conditional processing
awk '$3 > 1000 {print $1}' /etc/passwd

# Built-in variables
awk '{print NR, NF, $0}' file.txt  # NR=line number, NF=field count
```

### DevOps Examples:
```bash
# Parse system information
df -h | awk 'NR>1 {print $1, $5}' | sed 's/%//'

# Process log files
awk '$9 == 404 {print $7}' access.log

# Calculate statistics
awk '{sum+=$2} END {print "Total:", sum}' data.txt

# Extract metrics
free | awk '/^Mem:/ {printf "Memory Usage: %.1f%%\n", $3/$2*100}'
```

## 📝 Hands-on Exercises

### Exercise 1: Log Analysis
```bash
# Create sample log files
mkdir -p /tmp/logs
cat > /tmp/logs/app.log << EOF
2024-01-15 10:30:15 INFO User login successful
2024-01-15 10:31:22 ERROR Database connection failed
2024-01-15 10:32:01 WARNING High memory usage detected
2024-01-15 10:33:45 INFO User logout
2024-01-15 10:34:12 ERROR File not found: config.json
EOF

# Find all errors
grep -n "ERROR" /tmp/logs/app.log

# Count different log levels
grep -c "ERROR\|WARNING\|INFO" /tmp/logs/app.log

# Extract timestamps of errors
grep "ERROR" /tmp/logs/app.log | awk '{print $1, $2}'
```

### Exercise 2: Configuration Management
```bash
# Create sample nginx config
cat > /tmp/nginx.conf << EOF
server {
    listen 80;
    server_name example.com;
    root /var/www/html;
    
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Change server name
sed -i 's/server_name example.com;/server_name newdomain.com;/' /tmp/nginx.conf

# Add SSL configuration
sed -i '/listen 80;/a\    listen 443 ssl;' /tmp/nginx.conf

# Show the modified config
cat /tmp/nginx.conf
```

### Exercise 3: System Monitoring
```bash
# Monitor disk usage
df -h | awk 'NR>1 && $5+0 > 80 {print $1 " is " $5 " full"}'

# Process monitoring
ps aux | awk 'NR>1 && $3+0 > 5.0 {print $11, $3"% CPU"}'

# Network statistics
ss -tuln | awk '/:80/ {print "Port 80 is listening"}'
```

## 🎯 DevOps Scenarios

### Scenario 1: Application Deployment Log Analysis
```bash
#!/bin/bash
# deployment_log_analyzer.sh

LOG_FILE="/var/log/deployment.log"

echo "=== Deployment Analysis ==="
echo "Total deployment attempts: $(grep -c "Deployment started" $LOG_FILE)"
echo "Successful deployments: $(grep -c "Deployment completed successfully" $LOG_FILE)"
echo "Failed deployments: $(grep -c "Deployment failed" $LOG_FILE)"

echo ""
echo "Recent errors:"
grep "ERROR" $LOG_FILE | tail -5

echo ""
echo "Deployment times:"
grep "Deployment completed" $LOG_FILE | awk '{print $1, $2, $(NF-1), $NF}'
```

### Scenario 2: Configuration File Automation
```bash
#!/bin/bash
# update_config.sh - Update application configuration

CONFIG_FILE="/etc/myapp/config.conf"
BACKUP_DIR="/etc/myapp/backups"

# Backup original config
cp "$CONFIG_FILE" "$BACKUP_DIR/config.$(date +%Y%m%d_%H%M%S).conf"

# Update database connection
sed -i 's/db_host=.*/db_host=new-database-server/' "$CONFIG_FILE"

# Update log level
sed -i 's/log_level=.*/log_level=INFO/' "$CONFIG_FILE"

# Verify changes
echo "Updated configuration:"
grep -E "(db_host|log_level)" "$CONFIG_FILE"
```

### Scenario 3: Performance Monitoring
```bash
#!/bin/bash
# performance_monitor.sh

echo "=== System Performance Report ==="
echo "Date: $(date)"
echo ""

echo "Memory Usage:"
free -h | awk 'NR==2 {printf "Used: %s / %s (%.1f%%)\n", $3, $2, $3/$2*100}'

echo ""
echo "Disk Usage:"
df -h | awk 'NR>1 && $5+0 > 80 {printf "WARNING: %s is %s full\n", $1, $5}'

echo ""
echo "Top CPU Processes:"
ps aux | sort -k3 -nr | head -5 | awk '{printf "%-15s %5s%%\n", $11, $3}'

echo ""
echo "Active Connections:"
ss -tuln | grep -c LISTEN | awk '{print "Listening ports: " $1}'
```

## 🔗 Combining Tools

### Complex Pipelines:
```bash
# Find top 10 IP addresses in access log
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -10

# Monitor application logs in real-time
tail -f /var/log/app.log | grep --line-buffered "ERROR\|CRITICAL" | while read line; do
    echo "$(date): $line" >> /var/log/critical.log
done

# Generate system report
{
    echo "=== System Report $(date) ==="
    echo "Uptime: $(uptime)"
    echo "Memory: $(free | awk '/^Mem:/ {printf "%.1f%% used\n", $3/$2*100}')"
    echo "Disk: $(df -h / | awk 'NR==2 {print $5 " used"}')"
    echo "Load: $(uptime | awk -F'load average:' '{print $2}')"
} | tee /tmp/system_report.txt
```

## 💡 Best Practices

1. **Use specific patterns**: Avoid overly broad grep patterns
2. **Test sed commands**: Use dry-run mode or backups
3. **Handle edge cases**: Check for empty files or missing data
4. **Performance**: Use appropriate tools for large files
5. **Readability**: Add comments to complex pipelines

## ✅ Check Your Understanding

1. How would you find all 404 errors in an access log?
2. How do you replace a configuration value in a file?
3. How would you extract the top 5 processes by CPU usage?
4. What's the difference between grep -v and grep -i?
5. How do you process only lines that match a pattern in awk?

## 🚀 Next Steps

Ready to learn about process management? Move on to [Process Management](../process-management/) to understand how to monitor and control system processes.

---

> **💡 Remember**: These tools are the foundation of log analysis and automation in DevOps. Practice with real log files and configuration files!
