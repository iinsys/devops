# YAML Comments

Comments in YAML are essential for documenting your configuration files, explaining complex structures, and making your YAML files more maintainable. YAML uses the `#` character to denote comments.

## 💬 Comment Basics

### Single Line Comments
```yaml
# This is a single line comment
name: John Doe  # This is an inline comment
age: 30        # Age in years
email: john@example.com  # Contact email
```

### Multi-Line Comments
```yaml
# This is a multi-line comment
# Each line starts with #
# Comments help explain complex configurations

application:
  name: "My App"
  version: "2.1.0"
```

## 🔧 Real-World Examples

### Kubernetes Configuration with Comments
```yaml
# Kubernetes Deployment Configuration
# This file defines a web application deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
    environment: production  # Environment tag for resource management
    version: v1.0.0
spec:
  replicas: 3  # Number of pod replicas for high availability
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
          name: http
        - containerPort: 443
          name: https
        env:
        - name: NGINX_HOST
          value: "localhost"
        - name: NGINX_PORT
          value: "80"
        resources:
          requests:
            memory: "64Mi"    # Minimum memory requirement
            cpu: "250m"       # Minimum CPU requirement (0.25 cores)
          limits:
            memory: "128Mi"   # Maximum memory allocation
            cpu: "500m"       # Maximum CPU allocation (0.5 cores)
```

### Docker Compose with Documentation
```yaml
# Multi-service application configuration
# This file defines a complete application stack with web, API, and database services
version: '3.8'
services:
  # Web server using nginx
  web:
    image: nginx:latest
    container_name: web-server
    ports:
      - "80:80"    # HTTP port
      - "443:443"  # HTTPS port
    environment:
      NGINX_HOST: localhost
      NGINX_PORT: 80
    volumes:
      - ./html:/usr/share/nginx/html  # Mount static content
      - ./logs:/var/log/nginx         # Mount log directory
      - ./ssl:/etc/nginx/ssl          # Mount SSL certificates
    networks:
      - frontend  # Public network
      - backend   # Private network
    depends_on:
      - api       # Ensure API is started first
      - database  # Ensure database is started first
    restart: unless-stopped

  # API server using Node.js
  api:
    image: node:16-alpine
    container_name: api-server
    working_dir: /app
    volumes:
      - ./api:/app              # Mount application code
      - /app/node_modules       # Exclude node_modules from mount
    ports:
      - "3000:3000"  # API port
    environment:
      NODE_ENV: production
      DATABASE_URL: postgresql://user:pass@database:5432/myapp
      REDIS_URL: redis://cache:6379
    networks:
      - backend  # Private network only
    depends_on:
      - database
      - cache
    restart: unless-stopped

  # PostgreSQL database
  database:
    image: postgres:13
    container_name: postgres-db
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_INITDB_ARGS: "--encoding=UTF-8 --lc-collate=C --lc-ctype=C"
    volumes:
      - postgres_data:/var/lib/postgresql/data  # Persistent data storage
      - ./init-scripts:/docker-entrypoint-initdb.d  # Initialization scripts
    networks:
      - backend
    ports:
      - "5432:5432"  # Database port (exposed for development)
    restart: unless-stopped

# Network definitions
networks:
  frontend:
    driver: bridge  # Public network for web traffic
  backend:
    driver: bridge  # Private network for internal communication

# Volume definitions for persistent data
volumes:
  postgres_data:
    driver: local  # Local storage for database data
```

### Ansible Playbook with Detailed Comments
```yaml
# Ansible Playbook for Web Server Configuration
# This playbook configures a complete web server environment
---
- name: Configure Production Web Server
  hosts: webservers
  become: yes  # Use sudo privileges
  vars:
    app_name: "myapp"
    app_version: "2.1.0"
    # Environment-specific variables
    environments:
      development:
        database_host: "localhost"
        database_port: 5432
        debug: true
        log_level: "debug"
      staging:
        database_host: "staging-db.example.com"
        database_port: 5432
        debug: false
        log_level: "info"
      production:
        database_host: "prod-db.example.com"
        database_port: 5432
        debug: false
        log_level: "warn"

  tasks:
    # Install required system packages
    - name: Install system packages
      apt:
        name:
          - nginx          # Web server
          - postgresql-client  # Database client
          - redis-tools    # Redis client
          - curl          # HTTP client
          - wget          # File download utility
        state: present
        update_cache: yes  # Update package cache before installation

    # Create application directory structure
    - name: Create application directories
      file:
        path: "{{ item }}"
        state: directory
        mode: '0755'      # Read/write/execute for owner, read/execute for group/others
        owner: "{{ app_user }}"
        group: "{{ app_group }}"
      loop:
        - "/opt/{{ app_name }}"           # Main application directory
        - "/opt/{{ app_name }}/logs"      # Log files directory
        - "/opt/{{ app_name }}/config"    # Configuration files directory
        - "/opt/{{ app_name }}/data"      # Data files directory

    # Configure application services
    - name: Configure application services
      template:
        src: "{{ item.src }}"
        dest: "{{ item.dest }}"
        mode: '0644'      # Read/write for owner, read for group/others
        owner: "{{ app_user }}"
        group: "{{ app_group }}"
      loop:
        - src: "nginx.conf.j2"
          dest: "/etc/nginx/sites-available/{{ app_name }}"
        - src: "app.config.j2"
          dest: "/opt/{{ app_name }}/config/app.conf"
        - src: "systemd.service.j2"
          dest: "/etc/systemd/system/{{ app_name }}.service"

    # Enable and start system services
    - name: Enable and start services
      systemd:
        name: "{{ item }}"
        state: started
        enabled: yes       # Start service on boot
        daemon_reload: yes # Reload systemd configuration
      loop:
        - nginx
        - "{{ app_name }}"

    # Configure monitoring (conditional task)
    - name: Configure monitoring
      block:
        # Install monitoring tools
        - name: Install monitoring tools
          apt:
            name:
              - prometheus  # Metrics collection
              - grafana     # Visualization dashboard
            state: present

        # Configure Prometheus
        - name: Configure Prometheus
          template:
            src: "prometheus.yml.j2"
            dest: "/etc/prometheus/prometheus.yml"
            mode: '0644'
            owner: prometheus
            group: prometheus
          notify: restart prometheus  # Trigger handler

        # Configure Grafana
        - name: Configure Grafana
          template:
            src: "grafana.ini.j2"
            dest: "/etc/grafana/grafana.ini"
            mode: '0644'
            owner: grafana
            group: grafana
          notify: restart grafana  # Trigger handler
      when: monitoring_enabled | default(false)  # Only run if monitoring is enabled

  # Handlers for service restarts
  handlers:
    - name: restart nginx
      systemd:
        name: nginx
        state: restarted

    - name: restart prometheus
      systemd:
        name: prometheus
        state: restarted

    - name: restart grafana
      systemd:
        name: grafana-server
        state: restarted
```

## 🧩 Advanced Comment Examples

### Configuration Documentation
```yaml
# Application Configuration File
# This file contains all configuration settings for the application
# Last updated: 2024-01-15
# Version: 2.1.0

application:
  # Basic application information
  name: "My Web Application"
  version: "2.1.0"
  description: "A modern web application built with Node.js and React"

  # Database configuration
  # Supports PostgreSQL, MySQL, and SQLite
  database:
    type: "postgresql"  # Options: postgresql, mysql, sqlite
    host: "localhost"
    port: 5432
    name: "myapp"
    user: "db_user"
    password: "{{ vault_db_password }}"  # Use Ansible vault for secrets
    ssl: true
    connection_timeout: 30  # Connection timeout in seconds
    max_pool_size: 20      # Maximum number of connections in pool

  # Cache configuration
  # Redis is used for session storage and caching
  cache:
    type: "redis"
    host: "localhost"
    port: 6379
    password: "{{ vault_redis_password }}"
    database: 0
    ttl: 3600  # Time to live in seconds

  # Logging configuration
  logging:
    level: "info"  # Options: debug, info, warn, error
    format: "json"  # Options: json, text
    file: "/var/log/myapp/app.log"
    max_size: "100MB"  # Maximum log file size
    max_files: 10      # Maximum number of log files to keep

  # Security settings
  security:
    session_secret: "{{ vault_session_secret }}"
    bcrypt_rounds: 12  # Password hashing rounds
    jwt_secret: "{{ vault_jwt_secret }}"
    cors_origins:
      - "https://app.example.com"
      - "https://admin.example.com"
      - "http://localhost:3000"  # Development only

  # Feature flags
  # Enable/disable features without code deployment
  features:
    authentication: true
    registration: true
    email_verification: true
    two_factor_auth: false  # Coming soon
    social_login: false     # Coming soon
    api_rate_limiting: true
    file_upload: true
    real_time_notifications: false  # Coming soon

  # Performance settings
  performance:
    compression: true
    minification: true
    caching: true
    cdn_enabled: false  # Enable for production
    worker_processes: 4  # Number of worker processes

  # Monitoring and health checks
  monitoring:
    health_check_path: "/health"
    metrics_path: "/metrics"
    readiness_path: "/ready"
    liveness_path: "/live"
    check_interval: 30  # Health check interval in seconds
```

### Infrastructure Configuration
```yaml
# Infrastructure Configuration
# This file defines the complete infrastructure setup
# Environment: Production
# Region: us-west-2

infrastructure:
  # Virtual Private Cloud (VPC) configuration
  vpc:
    name: "production-vpc"
    cidr: "10.0.0.0/16"
    enable_dns_hostnames: true
    enable_dns_support: true
    
    # Subnet configuration
    subnets:
      # Public subnets for load balancers and bastion hosts
      public:
        - name: "public-1a"
          cidr: "10.0.1.0/24"
          az: "us-west-2a"
          auto_assign_public_ip: true
        - name: "public-1b"
          cidr: "10.0.2.0/24"
          az: "us-west-2b"
          auto_assign_public_ip: true
      
      # Private subnets for application servers
      private:
        - name: "private-1a"
          cidr: "10.0.10.0/24"
          az: "us-west-2a"
          auto_assign_public_ip: false
        - name: "private-1b"
          cidr: "10.0.11.0/24"
          az: "us-west-2b"
          auto_assign_public_ip: false
      
      # Database subnets for RDS instances
      database:
        - name: "db-1a"
          cidr: "10.0.20.0/24"
          az: "us-west-2a"
        - name: "db-1b"
          cidr: "10.0.21.0/24"
          az: "us-west-2b"

  # Compute resources
  compute:
    # Application servers
    app_servers:
      - name: "app-server-1"
        instance_type: "t3.medium"  # 2 vCPU, 4 GB RAM
        ami: "ami-12345678"
        key_name: "production-key"
        security_groups:
          - "app-sg"
          - "ssh-sg"
        user_data: |
          #!/bin/bash
          yum update -y
          yum install -y nginx
          systemctl start nginx
          systemctl enable nginx
      
      - name: "app-server-2"
        instance_type: "t3.medium"
        ami: "ami-12345678"
        key_name: "production-key"
        security_groups:
          - "app-sg"
          - "ssh-sg"
    
    # Database servers
    db_servers:
      - name: "db-server-1"
        instance_type: "db.r5.large"  # 2 vCPU, 16 GB RAM
        engine: "postgres"
        version: "13.7"
        storage: 100  # GB
        backup_retention: 30  # days
        multi_az: true

  # Security groups
  security_groups:
    # Web server security group
    web_sg:
      name: "web-sg"
      description: "Security group for web servers"
      rules:
        - type: "ingress"
          port: 80
          protocol: "tcp"
          source: "0.0.0.0/0"
        - type: "ingress"
          port: 443
          protocol: "tcp"
          source: "0.0.0.0/0"
    
    # Application server security group
    app_sg:
      name: "app-sg"
      description: "Security group for application servers"
      rules:
        - type: "ingress"
          port: 3000
          protocol: "tcp"
          source: "web-sg"
        - type: "ingress"
          port: 22
          protocol: "tcp"
          source: "bastion-sg"
    
    # Database security group
    db_sg:
      name: "db-sg"
      description: "Security group for database servers"
      rules:
        - type: "ingress"
          port: 5432
          protocol: "tcp"
          source: "app-sg"
```

## ⚠️ Common Mistakes

### 1. Comment Placement Issues
```yaml
# ❌ Wrong - comment after value without space
name:John Doe# This is wrong

# ✅ Correct - space after value
name: John Doe  # This is correct
```

### 2. Inconsistent Comment Style
```yaml
# ❌ Wrong - inconsistent comment style
application:
  name: My App
  # Database settings
  database:
    host: localhost
    port: 5432
  # Cache settings
  cache:
    host: localhost
    port: 6379

# ✅ Correct - consistent comment style
application:
  name: My App
  
  # Database settings
  database:
    host: localhost
    port: 5432
  
  # Cache settings
  cache:
    host: localhost
    port: 6379
```

### 3. Over-Commenting
```yaml
# ❌ Wrong - too many obvious comments
application:
  name: "My App"  # Application name
  version: "2.1.0"  # Application version
  debug: false  # Debug mode
  port: 3000  # Port number

# ✅ Correct - comment only what's not obvious
application:
  name: "My App"
  version: "2.1.0"
  debug: false
  port: 3000  # Development port, production uses 80
```

## 📋 Best Practices

### 1. Use Descriptive Comments
```yaml
# Good commenting
application:
  # Database connection settings
  database:
    host: "localhost"
    port: 5432
    name: "myapp"
    user: "db_user"
    password: "{{ vault_db_password }}"  # Use vault for secrets
  
  # Cache configuration for session storage
  cache:
    type: "redis"
    host: "localhost"
    port: 6379
    ttl: 3600  # Session timeout in seconds
```

### 2. Group Related Comments
```yaml
# Application configuration
application:
  name: "My App"
  version: "2.1.0"
  
  # Database settings
  database:
    host: "localhost"
    port: 5432
  
  # Cache settings
  cache:
    host: "localhost"
    port: 6379
  
  # Security settings
  security:
    session_secret: "{{ vault_session_secret }}"
    jwt_secret: "{{ vault_jwt_secret }}"
```

### 3. Document Complex Configurations
```yaml
# Complex configuration with detailed comments
monitoring:
  # Prometheus configuration for metrics collection
  prometheus:
    enabled: true
    port: 9090
    retention_days: 30
    scrape_interval: 15s  # How often to collect metrics
    
    # Targets to scrape metrics from
    targets:
      - "app-server-1:3000"
      - "app-server-2:3000"
      - "db-server:5432"
  
  # Grafana configuration for visualization
  grafana:
    enabled: true
    port: 3000
    admin_password: "{{ vault_grafana_password }}"
    
    # Pre-configured dashboards
    dashboards:
      - name: "System Overview"
        uid: "system-overview"
      - name: "Application Metrics"
        uid: "app-metrics"
```

### 4. Use Comments for Version Control
```yaml
# Configuration file for MyApp
# Version: 2.1.0
# Last updated: 2024-01-15
# Author: DevOps Team

application:
  name: "My App"
  version: "2.1.0"
  
  # Database configuration
  # Updated to support connection pooling
  database:
    host: "localhost"
    port: 5432
    max_connections: 20  # Added in v2.1.0
```

## 🔍 Working with Comments

### Python Example
```python
import yaml

# Load YAML with comments
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

# Comments are not preserved in the loaded data
# But you can add documentation in your code
print("Application configuration:")
print(f"Name: {config['application']['name']}")
print(f"Version: {config['application']['version']}")

# Document the configuration structure
def print_config_info(config):
    """Print information about the configuration structure."""
    print("Configuration sections:")
    for section in config.keys():
        print(f"  - {section}")
```

### JavaScript Example
```javascript
const yaml = require('js-yaml');
const fs = require('fs');

// Load YAML
const config = yaml.load(fs.readFileSync('config.yaml', 'utf8'));

// Comments are not preserved in the loaded data
// But you can add documentation in your code
console.log('Application configuration:');
console.log(`Name: ${config.application.name}`);
console.log(`Version: ${config.application.version}`);

// Document the configuration structure
function printConfigInfo(config) {
    console.log('Configuration sections:');
    Object.keys(config).forEach(section => {
        console.log(`  - ${section}`);
    });
}
```

## 🎯 Key Takeaways

- **Use `#` for comments** in YAML
- **Add space after `#`** for better readability
- **Comment complex configurations** to explain their purpose
- **Use consistent comment style** throughout your files
- **Document important decisions** and configuration choices
- **Avoid over-commenting** obvious values
- **Group related comments** for better organization

## 📚 Next Steps

After mastering comments, explore:
- [Quoting Rules](./../quoting-rules/README.md) - Advanced string handling
- [Basic Syntax](./../basic-syntax/README.md) - Review fundamentals
- [Nested Structures](./../nested-structures/README.md) - Complex data organization 