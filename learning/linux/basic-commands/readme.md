# Basic Linux Commands

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Use essential file and directory commands
- Understand command syntax and options
- Navigate the file system efficiently
- Create, read, and manage files and directories

## 📚 Essential Commands Overview

These commands form the foundation of Linux system administration and are essential for DevOps work.

## 📁 File and Directory Commands

### 1. `ls` - List Directory Contents
```bash
# Basic listing
ls

# Detailed listing with permissions, size, date
ls -l

# Show hidden files (starting with .)
ls -a

# Combine options
ls -la

# Human-readable file sizes
ls -lh

# Sort by modification time (newest first)
ls -lt

# Sort by size (largest first)
ls -lS
```

### 2. `pwd` - Print Working Directory
```bash
# Show current directory path
pwd
```

### 3. `cd` - Change Directory
```bash
# Go to home directory
cd ~
cd

# Go to root directory
cd /

# Go up one level
cd ..

# Go up multiple levels
cd ../../

# Go to previous directory
cd -

# Go to specific directory
cd /path/to/directory
```

### 4. `mkdir` - Create Directories
```bash
# Create single directory
mkdir newdir

# Create multiple directories
mkdir dir1 dir2 dir3

# Create nested directories
mkdir -p parent/child/grandchild

# Set permissions while creating
mkdir -m 755 newdir
```

### 5. `rmdir` - Remove Empty Directories
```bash
# Remove empty directory
rmdir emptydir

# Remove multiple empty directories
rmdir dir1 dir2 dir3
```

### 6. `rm` - Remove Files and Directories
```bash
# Remove file
rm filename

# Remove multiple files
rm file1 file2 file3

# Remove directory and contents recursively
rm -r directory

# Force removal without confirmation
rm -f filename

# Interactive removal (ask before each deletion)
rm -i filename

# Remove directory recursively with confirmation
rm -ri directory
```

## 📄 File Operations

### 7. `touch` - Create Empty Files
```bash
# Create single file
touch newfile.txt

# Create multiple files
touch file1.txt file2.txt file3.txt

# Update modification time of existing file
touch existingfile.txt
```

### 8. `cp` - Copy Files and Directories
```bash
# Copy file
cp source.txt destination.txt

# Copy file to directory
cp file.txt /path/to/directory/

# Copy directory recursively
cp -r sourcedir/ destinationdir/

# Preserve permissions and timestamps
cp -p source.txt destination.txt

# Interactive copy (ask before overwriting)
cp -i source.txt destination.txt
```

### 9. `mv` - Move/Rename Files and Directories
```bash
# Rename file
mv oldname.txt newname.txt

# Move file to directory
mv file.txt /path/to/directory/

# Move directory
mv sourcedir/ /path/to/destination/

# Move and rename
mv file.txt /path/to/newname.txt
```

### 10. `cat` - Display File Contents
```bash
# Display entire file
cat filename.txt

# Display multiple files
cat file1.txt file2.txt

# Display with line numbers
cat -n filename.txt

# Display non-printing characters
cat -A filename.txt
```

### 11. `less` and `more` - View Large Files
```bash
# View file with pagination (better for large files)
less filename.txt

# Navigation in less:
# Space: next page
# b: previous page
# q: quit
# /search: search for text
# n: next search result

# View file with pagination (older command)
more filename.txt
```

### 12. `head` and `tail` - View File Beginnings and Ends
```bash
# Show first 10 lines (default)
head filename.txt

# Show first 20 lines
head -n 20 filename.txt

# Show last 10 lines (default)
tail filename.txt

# Show last 20 lines
tail -n 20 filename.txt

# Follow file changes in real-time (useful for logs)
tail -f /var/log/syslog
```

## 🔍 File Information Commands

### 13. `file` - Determine File Type
```bash
# Check file type
file filename.txt

# Check multiple files
file *.txt
```

### 14. `wc` - Word Count
```bash
# Count lines, words, and characters
wc filename.txt

# Count only lines
wc -l filename.txt

# Count only words
wc -w filename.txt

# Count only characters
wc -c filename.txt
```

### 15. `find` - Search for Files
```bash
# Find files by name
find /path -name "filename.txt"

# Find files by type
find /path -type f  # files only
find /path -type d  # directories only

# Find files by size
find /path -size +100M  # larger than 100MB
find /path -size -1M    # smaller than 1MB

# Find files by modification time
find /path -mtime -7    # modified in last 7 days
```

## 📝 Hands-on Exercises

### Exercise 1: File System Navigation
```bash
# Create a practice structure
mkdir -p linux-practice/{documents,scripts,logs}

# Navigate to each directory and create files
cd linux-practice/documents
touch notes.txt report.txt

cd ../scripts
touch backup.sh deploy.sh

cd ../logs
touch error.log access.log

# Return to practice directory
cd ..
```

### Exercise 2: File Operations Practice
```bash
# List all contents recursively
ls -laR

# Copy a file
cp documents/notes.txt documents/notes_backup.txt

# Move a file
mv documents/report.txt documents/archive/

# Create a text file with content
echo "This is a practice file" > practice.txt

# Append to file
echo "This is additional content" >> practice.txt

# View the file
cat practice.txt
```

### Exercise 3: File Information
```bash
# Check file types
file *

# Count lines in all text files
wc -l *.txt

# Find all .sh files
find . -name "*.sh"

# Find files larger than 1KB
find . -size +1k
```

## 🎯 DevOps Scenarios

### Scenario 1: Log File Management
```bash
# Create log directory structure
mkdir -p /var/log/myapp/{application,access,error}

# Copy log files
cp /var/log/syslog /var/log/myapp/application/

# Check log file sizes
ls -lh /var/log/myapp/application/

# View recent log entries
tail -20 /var/log/myapp/application/syslog
```

### Scenario 2: Backup Script Preparation
```bash
# Create backup directory structure
mkdir -p backups/$(date +%Y-%m-%d)

# Copy important files
cp -r /etc/nginx/ backups/$(date +%Y-%m-%d)/

# Create backup script
cat > backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y-%m-%d)
BACKUP_DIR="/backups/$DATE"
mkdir -p "$BACKUP_DIR"
cp -r /etc/nginx/ "$BACKUP_DIR/"
echo "Backup completed: $BACKUP_DIR"
EOF
```

## 💡 Pro Tips

1. **Use Tab Completion**: Type partial command/file name and press Tab
2. **Command History**: Use `history` command to see previous commands
3. **Aliases**: Create shortcuts for frequently used commands
4. **Wildcards**: Use `*` (any characters) and `?` (single character)
5. **Path Shortcuts**: `~` for home, `.` for current, `..` for parent

## 🔧 Command Options Reference

| Command | Common Options | Description |
|---------|----------------|-------------|
| `ls` | `-l`, `-a`, `-h`, `-t`, `-S` | List with various formats |
| `cp` | `-r`, `-i`, `-p`, `-v` | Copy with recursion, interactive, preserve, verbose |
| `mv` | `-i`, `-v` | Move with interactive, verbose |
| `rm` | `-r`, `-f`, `-i` | Remove with recursion, force, interactive |
| `find` | `-name`, `-type`, `-size`, `-mtime` | Search with various criteria |

## ✅ Check Your Understanding

1. How would you create a directory called "project" with a subdirectory "src"?
2. What's the difference between `rm -r` and `rmdir`?
3. How do you view the last 50 lines of a log file?
4. What command would you use to find all .conf files in /etc?
5. How do you copy a directory and all its contents?

## 🚀 Next Steps

Ready to learn about file permissions? Move on to [File Permissions](../file-permissions/) to understand Linux security and access control.

---

> **💡 Remember**: These commands are the building blocks of Linux administration. Practice them regularly to build muscle memory!
