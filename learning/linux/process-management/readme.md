# Process Management for DevOps

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Monitor running processes with ps, top, and htop
- Manage processes with kill, killall, and pkill
- Understand process states and priorities
- Monitor system resources and performance
- Troubleshoot application issues

## 🔄 Why Process Management Matters in DevOps

Process management is essential for:
- **Application Monitoring**: Track application health and performance
- **Resource Management**: Monitor CPU, memory, and I/O usage
- **Troubleshooting**: Identify and resolve performance issues
- **Service Management**: Control application lifecycle

## 📊 Viewing Processes

### ps - Process Status
```bash
# Show all running processes
ps aux

# Show processes in tree format
ps auxf

# Show processes for specific user
ps -u username

# Show process details by PID
ps -p 1234

# Show processes with custom format
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -10
```

### top - Real-time Process Viewer
```bash
# Start top (press 'q' to quit)
top

# Sort by CPU usage (press 'P')
top -o %CPU

# Sort by memory usage (press 'M')
top -o %MEM

# Show processes for specific user
top -u username

# Batch mode (non-interactive)
top -b -n 1 | head -20
```

### htop - Enhanced Process Viewer
```bash
# Install htop (if not available)
sudo apt install htop  # Ubuntu/Debian
sudo yum install htop  # CentOS/RHEL

# Start htop
htop

# Key bindings in htop:
# F6 - Sort by column
# F9 - Kill process
# F10 - Quit
```

## ⚡ Process Control

### kill - Terminate Processes
```bash
# Send TERM signal (graceful shutdown)
kill 1234

# Send KILL signal (force termination)
kill -9 1234
kill -KILL 1234

# Send different signals
kill -HUP 1234    # Hangup (reload config)
kill -USR1 1234   # User-defined signal
kill -TERM 1234   # Termination signal
```

### killall and pkill - Kill by Name
```bash
# Kill all processes by name
killall nginx
killall -9 python3

# Kill processes by pattern
pkill nginx
pkill -f "python.*script.py"

# Interactive killing
killall -i nginx

# Kill processes for specific user
pkill -u username firefox
```

## 📈 System Resource Monitoring

### Memory Usage
```bash
# Show memory usage
free -h

# Show memory usage continuously
watch -n 1 free -h

# Show detailed memory info
cat /proc/meminfo

# Show memory usage by process
ps aux --sort=-%mem | head -10
```

### CPU Usage
```bash
# Show CPU information
lscpu

# Show CPU usage
top -b -n 1 | grep "Cpu(s)"

# Show load average
uptime

# Monitor CPU usage continuously
watch -n 1 'cat /proc/loadavg'
```

### Disk I/O
```bash
# Show disk usage
df -h

# Show disk I/O statistics
iostat 1 5

# Show I/O by process
iotop  # May need: sudo apt install iotop
```

## 🔍 Process States and Signals

### Process States:
- **R (Running)**: Process is running or ready to run
- **S (Sleeping)**: Process is waiting for an event
- **D (Uninterruptible)**: Process is waiting for I/O
- **Z (Zombie)**: Process has terminated but parent hasn't reaped it
- **T (Stopped)**: Process is stopped by signal

### Common Signals:
```bash
SIGHUP (1)   - Hangup (reload configuration)
SIGINT (2)   - Interrupt (Ctrl+C)
SIGQUIT (3)  - Quit (Ctrl+\)
SIGTERM (15) - Termination (graceful shutdown)
SIGKILL (9)  - Kill (cannot be caught or ignored)
SIGUSR1 (10) - User-defined signal 1
SIGUSR2 (12) - User-defined signal 2
```

## 📝 Hands-on Exercises

### Exercise 1: Process Monitoring
```bash
# Find all nginx processes
ps aux | grep nginx

# Show top 5 processes by CPU usage
ps aux --sort=-%cpu | head -6

# Show top 5 processes by memory usage
ps aux --sort=-%mem | head -6

# Monitor system load
watch -n 2 'uptime && echo "" && free -h'
```

### Exercise 2: Process Control
```bash
# Start a background process
sleep 300 &

# Find the process ID
ps aux | grep sleep

# Kill the process gracefully
kill <PID>

# Start another process
ping google.com &

# Kill by name
killall ping
```

### Exercise 3: Resource Monitoring
```bash
# Create a resource monitoring script
cat > monitor.sh << 'EOF'
#!/bin/bash
echo "=== System Resources $(date) ==="
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Memory Usage: $(free | awk '/^Mem:/ {printf "%.1f%%\n", $3/$2*100}')"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $5}')"
echo "Top CPU Process: $(ps aux --sort=-%cpu | awk 'NR==2 {print $11 " (" $3 "%)"}')"
EOF

chmod +x monitor.sh
./monitor.sh
```

## 🎯 DevOps Scenarios

### Scenario 1: Application Health Check
```bash
#!/bin/bash
# health_check.sh - Check if application is running

APP_NAME="myapp"
APP_PORT=8080
PID_FILE="/var/run/$APP_NAME.pid"

# Check if process is running
if [[ -f "$PID_FILE" ]]; then
    PID=$(cat "$PID_FILE")
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "✅ $APP_NAME is running (PID: $PID)"
        
        # Check if port is listening
        if ss -tuln | grep -q ":$APP_PORT "; then
            echo "✅ Port $APP_PORT is listening"
        else
            echo "❌ Port $APP_PORT is not listening"
            exit 1
        fi
    else
        echo "❌ $APP_NAME process not running (stale PID file)"
        exit 1
    fi
else
    echo "❌ $APP_NAME PID file not found"
    exit 1
fi
```

### Scenario 2: High Memory Process Alert
```bash
#!/bin/bash
# memory_alert.sh - Alert on high memory usage

THRESHOLD=80
EMAIL="admin@example.com"

# Get memory usage percentage
MEMORY_USAGE=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2*100}')

if [[ $MEMORY_USAGE -gt $THRESHOLD ]]; then
    echo "⚠️  High memory usage detected: ${MEMORY_USAGE}%"
    
    # Get top memory consumers
    echo "Top memory consumers:"
    ps aux --sort=-%mem | head -6
    
    # Send alert (requires mail setup)
    echo "Memory usage is ${MEMORY_USAGE}% on $(hostname)" | \
        mail -s "High Memory Alert" "$EMAIL"
fi
```

### Scenario 3: Process Restart Automation
```bash
#!/bin/bash
# restart_service.sh - Restart service if not responding

SERVICE_NAME="$1"
MAX_ATTEMPTS=3
WAIT_TIME=30

if [[ -z "$SERVICE_NAME" ]]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

for attempt in $(seq 1 $MAX_ATTEMPTS); do
    echo "Attempt $attempt: Checking $SERVICE_NAME..."
    
    if systemctl is-active --quiet "$SERVICE_NAME"; then
        echo "✅ $SERVICE_NAME is running"
        exit 0
    else
        echo "❌ $SERVICE_NAME is not running, restarting..."
        systemctl restart "$SERVICE_NAME"
        sleep $WAIT_TIME
    fi
done

echo "❌ Failed to start $SERVICE_NAME after $MAX_ATTEMPTS attempts"
exit 1
```

## 🔧 Advanced Process Management

### Process Priority (nice values):
```bash
# Run process with low priority
nice -n 19 cpu_intensive_task

# Change priority of running process
renice +10 1234

# Show process priorities
ps -eo pid,ppid,ni,comm | sort -k3 -nr
```

### Background Jobs:
```bash
# Start job in background
long_running_task &

# List background jobs
jobs

# Bring job to foreground
fg %1

# Stop job (Ctrl+Z), then resume in background
bg %1

# Disown job (remove from job table)
disown %1
```

### Process Substitution:
```bash
# Compare output of two commands
diff <(ps aux) <(ps aux)

# Process file while it's being written
tail -f /var/log/app.log | grep "ERROR"
```

## 💡 Best Practices

1. **Monitor Continuously**: Use tools like htop or custom scripts
2. **Graceful Shutdowns**: Always try SIGTERM before SIGKILL
3. **Resource Limits**: Set appropriate limits for applications
4. **Logging**: Log process events for troubleshooting
5. **Automation**: Create scripts for common process management tasks

## ✅ Check Your Understanding

1. How do you find the process ID of a running application?
2. What's the difference between kill and kill -9?
3. How do you monitor CPU usage in real-time?
4. What does a zombie process indicate?
5. How do you run a process with low priority?

## 🚀 Next Steps

Ready to learn about package management? Move on to [Package Management](../package-management/) to understand how to install and manage software packages.

---

> **💡 Remember**: Process management is crucial for application monitoring and troubleshooting. Practice with real applications and services!
