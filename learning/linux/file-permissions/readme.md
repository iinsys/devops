# File Permissions and Ownership

## 🎯 Learning Objectives

By the end of this lesson, you will understand:
- Linux file permission system (rwx)
- User, group, and other permissions
- How to change file permissions with `chmod`
- How to change file ownership with `chown` and `chgrp`
- Special permissions and their security implications

## 🔐 Understanding Linux Permissions

Linux uses a robust permission system to control access to files and directories. This is crucial for:
- System security
- Multi-user environments
- Service isolation
- DevOps automation

## 👥 Users, Groups, and Others

### Permission Categories:
- **User (Owner)**: The file owner
- **Group**: Users belonging to the file's group
- **Other**: Everyone else

### Example Permission Display:
```bash
-rwxr-xr-- 1 james developers 1024 Jan 15 10:30 script.sh
│└─┬─┘└─┬─┘└─┬─┘
│  │    │    │
│  │    │    └─ Other permissions (r--)
│  │    └────── Group permissions (r-x)
│  └─────────── User permissions (rwx)
└────────────── File type (- for file, d for directory)
```

## 📊 Permission Types

### Read (r = 4)
- **Files**: View file contents
- **Directories**: List directory contents

### Write (w = 2)
- **Files**: Modify file contents
- **Directories**: Create, delete, rename files

### Execute (x = 1)
- **Files**: Run as executable
- **Directories**: Access directory (cd into it)

## 🔢 Numeric Permission System

Permissions can be represented as numbers:
- **Read**: 4
- **Write**: 2
- **Execute**: 1

### Common Permission Combinations:
```bash
7 = 4+2+1 = rwx (read, write, execute)
6 = 4+2+0 = rw- (read, write)
5 = 4+0+1 = r-x (read, execute)
4 = 4+0+0 = r-- (read only)
3 = 0+2+1 = -wx (write, execute)
2 = 0+2+0 = -w- (write only)
1 = 0+0+1 = --x (execute only)
0 = 0+0+0 = --- (no permissions)
```

## 🛠️ Changing Permissions with `chmod`

### Numeric Method:
```bash
# Set permissions for user, group, other
chmod 755 filename    # rwxr-xr-x
chmod 644 filename    # rw-r--r--
chmod 600 filename    # rw-------
chmod 777 filename    # rwxrwxrwx (NOT recommended)

# Common permission sets:
chmod 755 directory/  # Directory: rwxr-xr-x
chmod 644 file.txt    # File: rw-r--r--
chmod 600 secret.txt  # Private file: rw-------
chmod 750 script.sh   # Executable: rwxr-x---
```

### Symbolic Method:
```bash
# Add permissions
chmod u+x filename    # Add execute for user
chmod g+w filename    # Add write for group
chmod o+r filename    # Add read for others

# Remove permissions
chmod u-x filename    # Remove execute for user
chmod g-w filename    # Remove write for group
chmod o-r filename    # Remove read for others

# Set permissions
chmod u=rwx filename  # Set user permissions
chmod g=r filename    # Set group permissions
chmod o= filename     # Remove all other permissions

# Multiple changes
chmod u+x,g+w filename
chmod u=rwx,g=rx,o=r filename
```

### Recursive Permission Changes:
```bash
# Change permissions recursively
chmod -R 755 directory/

# Change permissions for all files in directory
find directory/ -type f -exec chmod 644 {} \;

# Change permissions for all directories
find directory/ -type d -exec chmod 755 {} \;
```

## 👤 Changing Ownership with `chown`

### Basic Usage:
```bash
# Change owner
chown newuser filename

# Change owner and group
chown newuser:newgroup filename

# Change only group
chown :newgroup filename

# Recursive ownership change
chown -R user:group directory/
```

## 👥 Changing Group with `chgrp`

```bash
# Change group
chgrp newgroup filename

# Recursive group change
chgrp -R newgroup directory/
```

## 🚨 Special Permissions

### 1. Set User ID (SUID) - 4000
```bash
# Set SUID bit
chmod u+s filename
chmod 4755 filename

# Example: /bin/passwd has SUID to allow password changes
ls -l /bin/passwd
```

### 2. Set Group ID (SGID) - 2000
```bash
# Set SGID bit
chmod g+s filename
chmod 2755 filename

# For directories: new files inherit group ownership
```

### 3. Sticky Bit - 1000
```bash
# Set sticky bit (common on /tmp)
chmod +t directory
chmod 1777 directory

# Prevents users from deleting others' files
```

## 📝 Hands-on Exercises

### Exercise 1: Permission Analysis
```bash
# Create practice files
mkdir permission-practice
cd permission-practice

touch file1.txt file2.txt
mkdir dir1

# Check current permissions
ls -la

# Analyze the output:
# -rw-r--r-- 1 user group 0 Jan 15 10:30 file1.txt
# drwxr-xr-x 2 user group 4096 Jan 15 10:30 dir1
```

### Exercise 2: Permission Changes
```bash
# Make file1.txt executable
chmod +x file1.txt
ls -la file1.txt

# Make file2.txt private (owner only)
chmod 600 file2.txt
ls -la file2.txt

# Set directory permissions
chmod 755 dir1
ls -la dir1

# Try to access file2.txt as different user (if available)
```

### Exercise 3: Ownership Changes
```bash
# Create a test user (requires sudo)
sudo useradd testuser

# Change ownership of file1.txt
sudo chown testuser file1.txt
ls -la file1.txt

# Change group ownership
sudo chgrp testuser file1.txt
ls -la file1.txt

# Change both owner and group
sudo chown testuser:testuser file2.txt
ls -la file2.txt
```

## 🎯 DevOps Scenarios

### Scenario 1: Web Server Setup
```bash
# Typical web server permissions
# HTML files: readable by web server
chmod 644 *.html
chmod 644 *.css
chmod 644 *.js

# Executable scripts: executable by web server
chmod 755 *.cgi
chmod 755 *.pl

# Configuration files: readable by web server
chmod 640 config.php
chown www-data:www-data config.php
```

### Scenario 2: SSH Key Management
```bash
# SSH private key must be private
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh/

# Authorized keys file
chmod 600 ~/.ssh/authorized_keys
```

### Scenario 3: Application Deployment
```bash
# Create application directory structure
mkdir -p /opt/myapp/{bin,config,logs,data}

# Set appropriate permissions
chown -R appuser:appgroup /opt/myapp
chmod 755 /opt/myapp/bin/*
chmod 640 /opt/myapp/config/*
chmod 755 /opt/myapp/logs
chmod 755 /opt/myapp/data

# Make scripts executable
chmod +x /opt/myapp/bin/*.sh
```

## 🔍 Permission Troubleshooting

### Common Issues and Solutions:

1. **Permission Denied**
   ```bash
   # Check file permissions
   ls -la filename
   
   # Check if you have the right permissions
   # Add execute permission if needed
   chmod +x filename
   ```

2. **Cannot Access Directory**
   ```bash
   # Directory needs execute permission to access
   chmod +x directory
   ```

3. **Cannot Write to File**
   ```bash
   # Add write permission
   chmod +w filename
   # Or for group
   chmod g+w filename
   ```

## 🛡️ Security Best Practices

### File Permissions:
- **Configuration files**: 640 (owner: rw, group: r, other: none)
- **Executable files**: 755 (owner: rwx, group: rx, other: rx)
- **Private files**: 600 (owner: rw, group: none, other: none)
- **Log files**: 644 (owner: rw, group: r, other: r)

### Directory Permissions:
- **Home directories**: 755 (owner: rwx, group: rx, other: rx)
- **Private directories**: 700 (owner: rwx, group: none, other: none)
- **Shared directories**: 755 (owner: rwx, group: rx, other: rx)

### Umask:
```bash
# Check current umask
umask

# Set umask (affects default permissions)
umask 022  # Default: 644 for files, 755 for directories
umask 077  # Restrictive: 600 for files, 700 for directories
```

## 📊 Permission Reference Table

| Permission | Numeric | Binary | Description |
|------------|---------|--------|-------------|
| --- | 0 | 000 | No permissions |
| --x | 1 | 001 | Execute only |
| -w- | 2 | 010 | Write only |
| -wx | 3 | 011 | Write + Execute |
| r-- | 4 | 100 | Read only |
| r-x | 5 | 101 | Read + Execute |
| rw- | 6 | 110 | Read + Write |
| rwx | 7 | 111 | Read + Write + Execute |

## ✅ Check Your Understanding

1. What do the permissions `rwxr-xr--` mean?
2. How would you make a script executable by everyone?
3. What's the difference between `chown user:group file` and `chgrp group file`?
4. Why might you set a file's permissions to 600?
5. What does the sticky bit do on directories?

## 🚀 Next Steps

Ready to learn about text processing? Move on to [Text Processing](../text-processing/) to master grep, sed, awk, and other powerful text manipulation tools.

---

> **💡 Remember**: Proper file permissions are essential for system security. Always follow the principle of least privilege!
