# Getting Started with Linux

## 🎯 Learning Objectives

By the end of this lesson, you will understand:
- What Linux is and why it's important in DevOps
- Different Linux distributions and their use cases
- How to access a Linux system
- Basic terminal navigation and commands

## 📚 What is Linux?

Linux is an open-source operating system kernel that serves as the foundation for many operating systems. In the DevOps world, Linux is the backbone of:
- Web servers
- Cloud infrastructure
- Container platforms
- CI/CD systems
- Monitoring tools

## 🐧 Linux Distributions

### Popular Distributions for DevOps:

1. **Ubuntu Server**
   - Most popular for cloud deployments
   - Excellent package management
   - Great community support

2. **CentOS/Rocky Linux/RHEL**
   - Enterprise-focused
   - Long-term support
   - Common in corporate environments

3. **Debian**
   - Stable and reliable
   - Minimal resource usage
   - Foundation for many other distros

4. **Alpine Linux**
   - Lightweight and secure
   - Popular for containers
   - Minimal attack surface

## 🚀 Getting Access to Linux

### Option 1: Cloud Instances
```bash
# AWS EC2, Google Cloud, Azure VMs
# Create a free tier instance for learning
```

### Option 2: Virtual Machines
```bash
# VirtualBox, VMware, or Hyper-V
# Install Ubuntu Desktop or Server
```

### Option 3: WSL (Windows Subsystem for Linux)
```bash
# For Windows users
wsl --install Ubuntu
```

### Option 4: Docker Container
```bash
# Quick Linux environment
docker run -it ubuntu:latest /bin/bash
```

## 🖥️ First Steps

### 1. Connect to Your System
```bash
# SSH connection (if remote)
ssh username@server-ip

# Local terminal access
# Open terminal application
```

### 2. Understanding the Terminal
The terminal (command line interface) is your primary tool for:
- File management
- System administration
- Automation
- Remote server management

### 3. Basic Navigation Commands
```bash
# Check current directory
pwd

# List files and directories
ls

# Change directory
cd /path/to/directory

# Go to home directory
cd ~
cd

# Go up one directory level
cd ..
```

## 📝 Hands-on Exercises

### Exercise 1: System Information
```bash
# Check Linux distribution
cat /etc/os-release

# Check kernel version
uname -a

# Check system architecture
uname -m
```

### Exercise 2: Basic Navigation
```bash
# Navigate to root directory
cd /

# List contents of root directory
ls -la

# Navigate to your home directory
cd ~

# Create a practice directory
mkdir linux-practice

# Navigate into it
cd linux-practice
```

### Exercise 3: File Operations
```bash
# Create a text file
touch hello.txt

# Add content to file
echo "Hello, Linux World!" > hello.txt

# Display file contents
cat hello.txt

# List files with details
ls -la
```

## 🔍 Understanding the Linux File System

### Key Directories:
```
/ (root)          # Top-level directory
/bin              # Essential system binaries
/etc              # System configuration files
/home             # User home directories
/var              # Variable data (logs, cache)
/tmp              # Temporary files
/opt              # Optional software packages
/usr              # User programs and utilities
```

## 💡 Pro Tips

1. **Use Tab Completion**: Press Tab to auto-complete commands and file names
2. **Command History**: Use ↑/↓ arrows to navigate command history
3. **Clear Screen**: Use `clear` or Ctrl+L to clear the terminal
4. **Exit Terminal**: Use `exit` or Ctrl+D to close the session

## 🎯 Practice Scenarios

### Scenario 1: DevOps Engineer Setup
You're setting up a new development server. Practice:
```bash
# Check system resources
free -h
df -h

# Check network connectivity
ping google.com

# Update package lists
sudo apt update  # Ubuntu/Debian
# or
sudo yum update  # CentOS/RHEL
```

### Scenario 2: File System Exploration
Explore the Linux file system:
```bash
# Navigate to different directories
cd /var/log
ls -la

cd /etc
ls -la | grep network

cd /home
ls -la
```

## 📖 Additional Resources

- [Linux Foundation Training](https://training.linuxfoundation.org/)
- [Linux Command Line Basics](https://ubuntu.com/tutorials/command-line-for-beginners)
- [DevOps Linux Commands Cheat Sheet](https://www.edureka.co/blog/linux-commands/)

## ✅ Check Your Understanding

1. What is the difference between Linux and a Linux distribution?
2. Name three popular Linux distributions used in DevOps.
3. What command would you use to check your current directory?
4. How do you navigate to your home directory?
5. What does the `ls -la` command do?

## 🚀 Next Steps

Ready for the next lesson? Move on to [File System Navigation](../file-system/) to learn about the Linux directory structure and navigation commands.

---

> **💡 Remember**: Practice makes perfect! Spend time exploring your Linux system and experimenting with these basic commands.
