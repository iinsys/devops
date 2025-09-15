# Networking for DevOps

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Configure network interfaces and IP addresses
- Use network troubleshooting tools (ping, traceroute, netstat, ss)
- Configure firewall rules with iptables and ufw
- Understand network protocols and ports
- Troubleshoot connectivity issues

## 🌐 Why Networking Matters in DevOps

Networking is essential for:
- **Service Communication**: Applications talking to each other
- **Load Balancing**: Distributing traffic across servers
- **Security**: Firewall rules and access control
- **Monitoring**: Network performance and connectivity
- **Cloud Integration**: VPCs, subnets, and security groups

## 🔧 Network Interface Management

### Viewing Network Interfaces
```bash
# Show all network interfaces
ip addr show
ip a

# Show specific interface
ip addr show eth0

# Show interface statistics
ip -s link show

# Show routing table
ip route show
ip r

# Show network statistics
ss -tuln
netstat -tuln
```

### Configuring Network Interfaces
```bash
# Bring interface up/down
sudo ip link set eth0 up
sudo ip link set eth0 down

# Configure IP address
sudo ip addr add 192.168.1.100/24 dev eth0

# Remove IP address
sudo ip addr del 192.168.1.100/24 dev eth0

# Configure default gateway
sudo ip route add default via 192.168.1.1

# Flush all routes
sudo ip route flush all
```

### Network Configuration Files
```bash
# Ubuntu/Debian - Netplan configuration
# /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]

# Apply netplan configuration
sudo netplan apply

# CentOS/RHEL - NetworkManager
# /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
BOOTPROTO=static
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=8.8.8.8
DNS2=8.8.4.4
ONBOOT=yes
```

## 🔍 Network Troubleshooting Tools

### Connectivity Testing
```bash
# Test connectivity
ping google.com
ping -c 4 8.8.8.8

# Trace network path
traceroute google.com
mtr google.com

# Test specific port
telnet google.com 80
nc -zv google.com 80

# Test DNS resolution
nslookup google.com
dig google.com
host google.com
```

### Port and Service Monitoring
```bash
# Show listening ports
ss -tuln
netstat -tuln

# Show established connections
ss -tuln
netstat -tuln

# Show connections by process
ss -tulnp
netstat -tulnp

# Show routing table
ip route show
route -n

# Show ARP table
ip neigh show
arp -a
```

### Network Performance
```bash
# Monitor network traffic
iftop
nethogs

# Show interface statistics
cat /proc/net/dev

# Monitor network connections
watch -n 1 'ss -tuln | wc -l'

# Test bandwidth
iperf3 -s  # Server
iperf3 -c server_ip  # Client
```

## 🔥 Firewall Configuration

### iptables - Advanced Firewall
```bash
# Show current rules
sudo iptables -L -n -v

# Show rules with line numbers
sudo iptables -L -n -v --line-numbers

# Allow SSH (port 22)
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP and HTTPS
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow specific IP range
sudo iptables -A INPUT -s 192.168.1.0/24 -j ACCEPT

# Drop all other traffic
sudo iptables -A INPUT -j DROP

# Save rules
sudo iptables-save > /etc/iptables/rules.v4

# Restore rules
sudo iptables-restore < /etc/iptables/rules.v4
```

### UFW - Uncomplicated Firewall
```bash
# Enable UFW
sudo ufw enable

# Show status
sudo ufw status verbose

# Allow SSH
sudo ufw allow ssh
sudo ufw allow 22

# Allow HTTP and HTTPS
sudo ufw allow 80
sudo ufw allow 443

# Allow from specific IP
sudo ufw allow from 192.168.1.100

# Allow to specific port
sudo ufw allow 8080

# Deny specific port
sudo ufw deny 3306

# Delete rule
sudo ufw delete allow 80

# Reset firewall
sudo ufw --force reset
```

## 📝 Hands-on Exercises

### Exercise 1: Network Interface Configuration
```bash
# Check current network configuration
ip addr show
ip route show

# Test connectivity
ping -c 4 8.8.8.8

# Check DNS resolution
nslookup google.com

# Show listening ports
ss -tuln | grep LISTEN
```

### Exercise 2: Firewall Setup
```bash
# Configure UFW for web server
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443

# Check firewall status
sudo ufw status verbose

# Test firewall rules
sudo ufw deny 8080
sudo ufw status numbered
sudo ufw delete 1  # Delete first rule
```

### Exercise 3: Network Troubleshooting
```bash
# Create network troubleshooting script
cat > network_check.sh << 'EOF'
#!/bin/bash
echo "=== Network Diagnostics ==="
echo "Date: $(date)"
echo ""

echo "Network Interfaces:"
ip addr show | grep -E "(inet |UP|DOWN)"

echo ""
echo "Routing Table:"
ip route show

echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf

echo ""
echo "Listening Ports:"
ss -tuln | grep LISTEN

echo ""
echo "Connectivity Test:"
ping -c 3 8.8.8.8
EOF

chmod +x network_check.sh
./network_check.sh
```

## 🎯 DevOps Scenarios

### Scenario 1: Web Server Network Setup
```bash
#!/bin/bash
# setup_web_server_network.sh

echo "Setting up web server network configuration..."

# Configure network interface
sudo tee /etc/netplan/01-web-server.yaml > /dev/null << EOF
network:
  version: 2
  ethernets:
    eth0:
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
EOF

# Apply network configuration
sudo netplan apply

# Configure firewall
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443

# Install and configure nginx
sudo apt update
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Test configuration
echo "Testing network configuration..."
ping -c 3 8.8.8.8
curl -I http://localhost

echo "✅ Web server network setup completed!"
```

### Scenario 2: Database Server Security
```bash
#!/bin/bash
# secure_database_server.sh

echo "Securing database server network..."

# Configure firewall for database server
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow from 192.168.1.0/24 to any port 3306  # MySQL
sudo ufw allow from 192.168.1.0/24 to any port 5432  # PostgreSQL

# Configure MySQL to bind to specific interface
sudo tee -a /etc/mysql/mysql.conf.d/mysqld.cnf > /dev/null << EOF
bind-address = 192.168.1.100
EOF

# Restart MySQL
sudo systemctl restart mysql

# Test database connectivity
echo "Testing database connectivity..."
nc -zv 192.168.1.100 3306

echo "✅ Database server secured!"
```

### Scenario 3: Load Balancer Configuration
```bash
#!/bin/bash
# setup_load_balancer.sh

echo "Setting up load balancer..."

# Install nginx
sudo apt update
sudo apt install -y nginx

# Configure load balancer
sudo tee /etc/nginx/sites-available/load-balancer > /dev/null << EOF
upstream backend {
    server 192.168.1.101:8080;
    server 192.168.1.102:8080;
    server 192.168.1.103:8080;
}

server {
    listen 80;
    server_name lb.example.com;
    
    location / {
        proxy_pass http://backend;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# Enable site
sudo ln -s /etc/nginx/sites-available/load-balancer /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Configure firewall
sudo ufw allow 80
sudo ufw allow 443

echo "✅ Load balancer configured!"
```

## 🔧 Advanced Networking

### Network Namespaces
```bash
# Create network namespace
sudo ip netns add test-ns

# List network namespaces
sudo ip netns list

# Execute command in namespace
sudo ip netns exec test-ns ip addr show

# Delete network namespace
sudo ip netns delete test-ns
```

### VLAN Configuration
```bash
# Create VLAN interface
sudo ip link add link eth0 name eth0.100 type vlan id 100

# Configure VLAN interface
sudo ip addr add 192.168.100.1/24 dev eth0.100
sudo ip link set eth0.100 up
```

### Bonding/Teaming
```bash
# Create bond interface
sudo ip link add bond0 type bond mode 802.3ad

# Add slaves to bond
sudo ip link set eth0 master bond0
sudo ip link set eth1 master bond0

# Configure bond interface
sudo ip addr add 192.168.1.100/24 dev bond0
sudo ip link set bond0 up
```

## 💡 Best Practices

1. **Security First**: Always configure firewalls
2. **Documentation**: Keep network diagrams updated
3. **Monitoring**: Monitor network performance
4. **Backup**: Backup network configurations
5. **Testing**: Test changes in staging first

## ✅ Check Your Understanding

1. How do you check if a port is listening?
2. What's the difference between iptables and ufw?
3. How do you test network connectivity?
4. How do you configure a static IP address?
5. How do you troubleshoot DNS resolution issues?

## 🚀 Next Steps

Ready to learn about cron jobs? Move on to [Cron Jobs](../cron-jobs/) to understand task scheduling and automation.

---

> **💡 Remember**: Networking is the foundation of distributed systems. Master these tools for effective DevOps operations!
