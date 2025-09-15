# Shell Scripting Basics

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Write basic shell scripts
- Use variables and command substitution
- Implement conditional statements and loops
- Handle user input and command-line arguments
- Create practical automation scripts for DevOps tasks

## 🐚 What is Shell Scripting?

Shell scripting is writing programs using shell commands to automate tasks. In DevOps, scripting is essential for:
- Deployment automation
- System administration
- Log processing
- Backup procedures
- Configuration management

## 📝 Script Structure

### Basic Script Template:
```bash
#!/bin/bash
# Script description
# Author: Your Name
# Date: $(date +%Y-%m-%d)

# Variables
SCRIPT_NAME="$(basename "$0")"

# Functions
function usage() {
    echo "Usage: $SCRIPT_NAME [options]"
    echo "Options:"
    echo "  -h    Show this help message"
}

# Main script logic
main() {
    echo "Script execution started..."
    # Your code here
    echo "Script completed successfully."
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

## 🔧 Creating Your First Script

### 1. Create the Script File:
```bash
# Create script file
touch my_first_script.sh

# Make it executable
chmod +x my_first_script.sh
```

### 2. Basic Script Example:
```bash
#!/bin/bash
# My First Script
# Simple greeting script

echo "Hello, World!"
echo "Current date: $(date)"
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
```

### 3. Run the Script:
```bash
# Execute the script
./my_first_script.sh

# Or run with bash
bash my_first_script.sh
```

## 📊 Variables

### Variable Assignment and Usage:
```bash
#!/bin/bash

# Variable assignment (no spaces around =)
NAME="John Doe"
AGE=25
CITY="New York"

# Using variables
echo "Name: $NAME"
echo "Age: $AGE"
echo "City: $CITY"

# Alternative syntax
echo "Name: ${NAME}"
echo "Full name: ${NAME}_${AGE}"
```

### Environment Variables:
```bash
#!/bin/bash

# Common environment variables
echo "Home directory: $HOME"
echo "Current user: $USER"
echo "Shell: $SHELL"
echo "Path: $PATH"

# Set environment variable for script
export MY_VAR="Hello from script"
echo "My variable: $MY_VAR"
```

### Command Substitution:
```bash
#!/bin/bash

# Capture command output
CURRENT_DATE=$(date)
CURRENT_USER=$(whoami)
FILE_COUNT=$(ls -1 | wc -l)

echo "Date: $CURRENT_DATE"
echo "User: $CURRENT_USER"
echo "Files in current directory: $FILE_COUNT"

# Alternative syntax with backticks (older style)
OLD_STYLE=`date`
echo "Old style: $OLD_STYLE"
```

## 🔄 Input and Arguments

### Reading User Input:
```bash
#!/bin/bash

# Read user input
echo "What's your name?"
read NAME

echo "What's your age?"
read AGE

echo "Hello $NAME, you are $AGE years old."
```

### Command-Line Arguments:
```bash
#!/bin/bash

# Access command-line arguments
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "Number of arguments: $#"

# Example usage:
# ./script.sh arg1 arg2 arg3
```

### Argument Processing:
```bash
#!/bin/bash

# Process arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Help message"
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -f|--file)
            FILE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo "Verbose: ${VERBOSE:-false}"
echo "File: ${FILE:-not specified}"
```

## 🎯 Conditional Statements

### If-Then-Else:
```bash
#!/bin/bash

# Basic if statement
if [[ $1 == "hello" ]]; then
    echo "You said hello!"
fi

# If-else statement
if [[ -f "$1" ]]; then
    echo "File exists: $1"
else
    echo "File does not exist: $1"
fi

# If-elif-else statement
if [[ $1 -gt 10 ]]; then
    echo "Number is greater than 10"
elif [[ $1 -eq 10 ]]; then
    echo "Number equals 10"
else
    echo "Number is less than 10"
fi
```

### File and Directory Tests:
```bash
#!/bin/bash

FILE="$1"

# File tests
if [[ -f "$FILE" ]]; then
    echo "Regular file exists"
fi

if [[ -d "$FILE" ]]; then
    echo "Directory exists"
fi

if [[ -r "$FILE" ]]; then
    echo "File is readable"
fi

if [[ -w "$FILE" ]]; then
    echo "File is writable"
fi

if [[ -x "$FILE" ]]; then
    echo "File is executable"
fi
```

### String Comparisons:
```bash
#!/bin/bash

NAME="$1"

# String comparisons
if [[ "$NAME" == "admin" ]]; then
    echo "Admin user detected"
fi

if [[ -z "$NAME" ]]; then
    echo "Name is empty"
fi

if [[ -n "$NAME" ]]; then
    echo "Name is not empty: $NAME"
fi
```

## 🔁 Loops

### For Loop:
```bash
#!/bin/bash

# Loop through numbers
for i in {1..5}; do
    echo "Number: $i"
done

# Loop through array
FRUITS=("apple" "banana" "orange")
for fruit in "${FRUITS[@]}"; do
    echo "Fruit: $fruit"
done

# Loop through files
for file in *.txt; do
    echo "Processing: $file"
done

# C-style for loop
for ((i=1; i<=5; i++)); do
    echo "Count: $i"
done
```

### While Loop:
```bash
#!/bin/bash

# Basic while loop
counter=1
while [[ $counter -le 5 ]]; do
    echo "Counter: $counter"
    ((counter++))
done

# Read file line by line
while IFS= read -r line; do
    echo "Line: $line"
done < input.txt
```

### Until Loop:
```bash
#!/bin/bash

# Until loop (opposite of while)
counter=1
until [[ $counter -gt 5 ]]; do
    echo "Counter: $counter"
    ((counter++))
done
```

## 🔧 Functions

### Basic Functions:
```bash
#!/bin/bash

# Function definition
function greet() {
    local name="$1"
    echo "Hello, $name!"
}

# Function with return value
function add() {
    local a="$1"
    local b="$2"
    echo $((a + b))
}

# Function with multiple return values
function get_info() {
    local file="$1"
    echo "$(stat -f%z "$file")"  # File size
    echo "$(stat -f%m "$file")"  # Modification time
}

# Using functions
greet "World"

result=$(add 5 3)
echo "5 + 3 = $result"

# Get file info
size=$(get_info "myfile.txt" | head -1)
echo "File size: $size"
```

## 📝 Hands-on Exercises

### Exercise 1: System Information Script
```bash
#!/bin/bash
# system_info.sh - Display system information

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "OS: $(uname -s)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo "Uptime: $(uptime -p)"
echo "Memory: $(free -h | grep '^Mem' | awk '{print $3 "/" $2}')"
echo "Disk Usage: $(df -h / | tail -1 | awk '{print $5}')"
```

### Exercise 2: File Backup Script
```bash
#!/bin/bash
# backup.sh - Simple backup script

BACKUP_DIR="/tmp/backup_$(date +%Y%m%d_%H%M%S)"
SOURCE_DIR="$1"

if [[ -z "$SOURCE_DIR" ]]; then
    echo "Usage: $0 <source_directory>"
    exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: $SOURCE_DIR is not a directory"
    exit 1
fi

echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

echo "Copying files from $SOURCE_DIR to $BACKUP_DIR"
cp -r "$SOURCE_DIR"/* "$BACKUP_DIR/"

echo "Backup completed successfully!"
echo "Backup location: $BACKUP_DIR"
```

### Exercise 3: Log Analyzer Script
```bash
#!/bin/bash
# log_analyzer.sh - Analyze log files

LOG_FILE="$1"

if [[ -z "$LOG_FILE" ]]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: $LOG_FILE not found"
    exit 1
fi

echo "=== Log Analysis: $LOG_FILE ==="
echo "Total lines: $(wc -l < "$LOG_FILE")"
echo "Error lines: $(grep -i error "$LOG_FILE" | wc -l)"
echo "Warning lines: $(grep -i warning "$LOG_FILE" | wc -l)"
echo "Info lines: $(grep -i info "$LOG_FILE" | wc -l)"

echo ""
echo "Top 10 most frequent error messages:"
grep -i error "$LOG_FILE" | sort | uniq -c | sort -nr | head -10
```

## 🎯 DevOps Scenarios

### Scenario 1: Deployment Script
```bash
#!/bin/bash
# deploy.sh - Application deployment script

APP_NAME="myapp"
VERSION="$1"
ENVIRONMENT="${2:-staging}"

if [[ -z "$VERSION" ]]; then
    echo "Usage: $0 <version> [environment]"
    exit 1
fi

echo "Deploying $APP_NAME version $VERSION to $ENVIRONMENT"

# Download application
wget "https://releases.example.com/$APP_NAME-$VERSION.tar.gz"

# Extract and setup
tar -xzf "$APP_NAME-$VERSION.tar.gz"
cd "$APP_NAME-$VERSION"

# Install dependencies
npm install --production

# Stop existing service
sudo systemctl stop "$APP_NAME"

# Backup current version
sudo cp -r "/opt/$APP_NAME" "/opt/$APP_NAME.backup.$(date +%Y%m%d_%H%M%S)"

# Deploy new version
sudo cp -r . "/opt/$APP_NAME"

# Start service
sudo systemctl start "$APP_NAME"
sudo systemctl enable "$APP_NAME"

echo "Deployment completed successfully!"
```

### Scenario 2: Health Check Script
```bash
#!/bin/bash
# health_check.sh - Service health monitoring

SERVICES=("nginx" "mysql" "redis")
ALERT_EMAIL="admin@example.com"

check_service() {
    local service="$1"
    
    if systemctl is-active --quiet "$service"; then
        echo "✅ $service is running"
        return 0
    else
        echo "❌ $service is not running"
        # Send alert (requires mail setup)
        echo "Service $service is down on $(hostname)" | mail -s "Service Alert" "$ALERT_EMAIL"
        return 1
    fi
}

echo "=== Service Health Check ==="
echo "Timestamp: $(date)"

failed_services=0
for service in "${SERVICES[@]}"; do
    if ! check_service "$service"; then
        ((failed_services++))
    fi
done

if [[ $failed_services -gt 0 ]]; then
    echo "⚠️  $failed_services service(s) failed health check"
    exit 1
else
    echo "✅ All services are healthy"
    exit 0
fi
```

## 💡 Best Practices

### 1. Error Handling:
```bash
#!/bin/bash

# Exit on any error
set -e

# Exit on undefined variables
set -u

# Exit on pipe failures
set -o pipefail

# Or use set -euo pipefail
```

### 2. Debugging:
```bash
#!/bin/bash

# Enable debug mode
set -x

# Your script commands here

# Disable debug mode
set +x
```

### 3. Script Organization:
```bash
#!/bin/bash

# Configuration section
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="/var/log/myapp.log"

# Function definitions
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE"
}

# Main script logic
main() {
    log "Script started"
    # Your code here
    log "Script completed"
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

## ✅ Check Your Understanding

1. How do you make a script executable?
2. What's the difference between `$1` and `$@`?
3. How do you check if a file exists in a script?
4. What's the purpose of the `set -e` option?
5. How do you capture command output in a variable?

## 🚀 Next Steps

Ready to learn about system information gathering? Move on to [System Information](../system-info/) to master commands for monitoring and understanding your Linux system.

---

> **💡 Remember**: Shell scripting is a powerful automation tool. Start simple and gradually add complexity as you become more comfortable!
