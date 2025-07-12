# YAML Quoting Rules

YAML provides flexible quoting options for strings, but understanding when and how to use them is crucial for creating robust and maintainable YAML files. This guide covers the different quoting styles and when to use each one.

## 📝 Quoting Basics

### No Quotes (Plain Strings)
```yaml
# Simple strings without quotes
name: John Doe
age: 30
email: john@example.com
path: /usr/local/bin
url: https://example.com/api/v1
```

### Single Quotes (`'`)
```yaml
# Single quotes for strings with special characters
version: '2.1.0'
path: '/usr/local/bin'
regex: '^[a-zA-Z0-9]+$'
description: 'This is a string with spaces'
```

### Double Quotes (`"`)
```yaml
# Double quotes for strings with escape sequences
message: "Hello\nWorld"
path: "C:\\Users\\John\\Documents"
regex: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
description: "This string contains \"quotes\" inside"
```

## 🔧 Real-World Examples

### Kubernetes Configuration
```yaml
# kubernetes-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  # No quotes needed for simple values
  app_name: myapp
  version: 2.1.0
  debug: false
  
  # Single quotes for paths and URLs
  log_file: '/var/log/myapp/app.log'
  database_url: 'postgresql://user:pass@localhost:5432/myapp'
  api_endpoint: 'https://api.example.com/v1'
  
  # Double quotes for strings with special characters
  welcome_message: "Welcome to MyApp!\nPlease log in to continue."
  error_message: "Error: \"Invalid credentials\""
  regex_pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
  
  # No quotes for simple lists
  allowed_origins:
    - https://app.example.com
    - https://admin.example.com
    - http://localhost:3000
  
  # Single quotes for paths in lists
  config_files:
    - '/etc/myapp/config.yml'
    - '/etc/myapp/secrets.yml'
    - '/var/log/myapp/access.log'
```

### Docker Compose Configuration
```yaml
# docker-compose.yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    container_name: web-server
    ports:
      - "80:80"
      - "443:443"
    environment:
      # No quotes for simple environment variables
      NGINX_HOST: localhost
      NGINX_PORT: 80
      DEBUG: false
      
      # Single quotes for paths and URLs
      LOG_FILE: '/var/log/nginx/access.log'
      STATIC_PATH: '/usr/share/nginx/html'
      API_URL: 'https://api.example.com/v1'
      
      # Double quotes for strings with special characters
      WELCOME_MESSAGE: "Welcome to our website!\nPlease enjoy your visit."
      ERROR_PAGE: "Error: \"Page not found\""
    volumes:
      # Single quotes for paths
      - './html:/usr/share/nginx/html'
      - './logs:/var/log/nginx'
      - '/etc/ssl/certs:/etc/nginx/ssl'
    command: |
      /bin/bash -c "
      echo 'Starting nginx...'
      nginx -g 'daemon off;'
      "

  api:
    image: node:16-alpine
    container_name: api-server
    working_dir: /app
    environment:
      NODE_ENV: production
      DATABASE_URL: 'postgresql://user:pass@database:5432/myapp'
      REDIS_URL: 'redis://cache:6379'
      LOG_LEVEL: info
      API_KEY: "{{ vault_api_key }}"
    volumes:
      - './api:/app'
      - '/app/node_modules'
    command: |
      sh -c "
      npm install
      npm start
      "
```

### Ansible Variables
```yaml
# vars.yaml
---
# Application configuration
application:
  # No quotes for simple values
  name: myapp
  version: 2.1.0
  debug: false
  port: 3000
  
  # Single quotes for paths and URLs
  log_file: '/var/log/myapp/app.log'
  config_file: '/etc/myapp/config.yml'
  database_url: 'postgresql://user:pass@localhost:5432/myapp'
  api_endpoint: 'https://api.example.com/v1'
  
  # Double quotes for strings with special characters
  welcome_message: "Welcome to MyApp!\nPlease log in to continue."
  error_message: "Error: \"Invalid credentials\""
  regex_pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"

# Database configuration
database:
  host: localhost
  port: 5432
  name: myapp
  user: db_user
  password: "{{ vault_db_password }}"
  ssl: true
  
  # Single quotes for connection strings
  connection_string: 'postgresql://user:pass@localhost:5432/myapp?sslmode=require'
  
  # Double quotes for complex strings
  init_script: |
    "CREATE DATABASE IF NOT EXISTS myapp;
     CREATE USER IF NOT EXISTS myapp_user;
     GRANT ALL PRIVILEGES ON myapp.* TO myapp_user;"

# Security settings
security:
  # No quotes for simple values
  session_timeout: 3600
  max_login_attempts: 5
  password_min_length: 8
  
  # Single quotes for secrets (when not using vault)
  jwt_secret: 'your-secret-key-here'
  session_secret: 'another-secret-key'
  
  # Double quotes for complex patterns
  password_regex: "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
  
  # No quotes for simple lists
  allowed_origins:
    - https://app.example.com
    - https://admin.example.com
    - http://localhost:3000
  
  # Single quotes for paths in lists
  ssl_certificates:
    - '/etc/ssl/certs/app.example.com.crt'
    - '/etc/ssl/private/app.example.com.key'
```

## 🧩 Advanced Examples

### Complex Configuration with Mixed Quoting
```yaml
# complex-config.yaml
application:
  # Basic information (no quotes needed)
  name: myapp
  version: 2.1.0
  environment: production
  debug: false
  
  # Paths and URLs (single quotes)
  config_file: '/etc/myapp/config.yml'
  log_file: '/var/log/myapp/app.log'
  static_path: '/usr/share/nginx/html'
  database_url: 'postgresql://user:pass@localhost:5432/myapp'
  redis_url: 'redis://localhost:6379'
  api_endpoint: 'https://api.example.com/v1'
  
  # Strings with special characters (double quotes)
  welcome_message: "Welcome to MyApp!\nPlease log in to continue."
  error_message: "Error: \"Invalid credentials\""
  success_message: "Success! Your changes have been saved."
  regex_pattern: "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
  
  # Configuration objects
  settings:
    # No quotes for simple values
    timeout: 30
    max_connections: 100
    cache_enabled: true
    
    # Single quotes for paths
    template_path: '/usr/share/myapp/templates'
    upload_path: '/var/uploads'
    
    # Double quotes for strings with special characters
    email_template: |
      "Dear {{ user.name }},\n\nThank you for registering with MyApp!\n\nBest regards,\nThe MyApp Team"
    
    # No quotes for simple lists
    supported_languages:
      - en
      - es
      - fr
      - de
    
    # Single quotes for paths in lists
    config_files:
      - '/etc/myapp/main.yml'
      - '/etc/myapp/secrets.yml'
      - '/etc/myapp/logging.yml'
    
    # Double quotes for strings with special characters in lists
    error_messages:
      - "Error: \"Invalid input\""
      - "Error: \"Connection failed\""
      - "Error: \"Authentication required\""

# Infrastructure configuration
infrastructure:
  # Network settings (no quotes for simple values)
  vpc_cidr: 10.0.0.0/16
  subnet_cidr: 10.0.1.0/24
  instance_type: t3.medium
  
  # Paths and URLs (single quotes)
  key_file: '/home/ubuntu/.ssh/myapp-key.pem'
  ssl_cert: '/etc/ssl/certs/myapp.example.com.crt'
  ssl_key: '/etc/ssl/private/myapp.example.com.key'
  backup_path: '/var/backups/myapp'
  
  # Strings with special characters (double quotes)
  user_data: |
    "#!/bin/bash
     yum update -y
     yum install -y nginx
     systemctl start nginx
     systemctl enable nginx"
  
  # No quotes for simple lists
  security_groups:
    - web-sg
    - app-sg
    - db-sg
  
  # Single quotes for paths in lists
  mount_points:
    - '/var/log'
    - '/var/www'
    - '/etc/nginx'
  
  # Double quotes for strings with special characters in lists
  environment_variables:
    - "NODE_ENV=production"
    - "DATABASE_URL=postgresql://user:pass@localhost:5432/myapp"
    - "REDIS_URL=redis://localhost:6379"
    - "LOG_LEVEL=info"
```

### Monitoring Configuration
```yaml
# monitoring-config.yaml
monitoring:
  # Basic settings (no quotes)
  enabled: true
  interval: 60
  retention_days: 30
  
  # Paths and URLs (single quotes)
  config_file: '/etc/prometheus/prometheus.yml'
  data_dir: '/var/lib/prometheus'
  log_file: '/var/log/prometheus/prometheus.log'
  grafana_config: '/etc/grafana/grafana.ini'
  
  # Strings with special characters (double quotes)
  alert_message: "Alert: \"High CPU usage detected\""
  notification_template: |
    "Alert: {{ .AlertName }}\nSeverity: {{ .Severity }}\nValue: {{ .Value }}"
  
  # Metrics configuration
  metrics:
    # No quotes for simple values
    cpu_threshold: 90
    memory_threshold: 85
    disk_threshold: 95
    
    # Single quotes for paths
    cpu_metric: 'node_cpu_seconds_total'
    memory_metric: 'node_memory_MemTotal_bytes'
    disk_metric: 'node_filesystem_size_bytes'
    
    # Double quotes for complex queries
    cpu_query: "100 - (avg by (instance) (irate(node_cpu_seconds_total{mode=\"idle\"}[5m])) * 100)"
    memory_query: "(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100"
  
  # Alerting configuration
  alerts:
    # No quotes for simple values
    enabled: true
    check_interval: 30
    
    # Single quotes for paths and URLs
    webhook_url: 'https://hooks.slack.com/services/xxx/yyy/zzz'
    email_smtp: 'smtp.gmail.com:587'
    
    # Double quotes for strings with special characters
    email_template: |
      "Subject: Alert - {{ .AlertName }}\n\nAlert: {{ .AlertName }}\nSeverity: {{ .Severity }}\nValue: {{ .Value }}\nTime: {{ .Timestamp }}"
    
    # No quotes for simple lists
    recipients:
      - admin@example.com
      - ops@example.com
    
    # Single quotes for paths in lists
    log_files:
      - '/var/log/nginx/access.log'
      - '/var/log/nginx/error.log'
      - '/var/log/myapp/app.log'
    
    # Double quotes for strings with special characters in lists
    notification_channels:
      - "email:admin@example.com"
      - "slack:#alerts"
      - "webhook:https://hooks.slack.com/services/xxx/yyy/zzz"
```

## ⚠️ Common Mistakes

### 1. Unnecessary Quotes
```yaml
# ❌ Wrong - unnecessary quotes
name: "John Doe"
age: "30"
debug: "false"
port: "3000"

# ✅ Correct - no quotes needed for simple values
name: John Doe
age: 30
debug: false
port: 3000
```

### 2. Missing Quotes for Special Characters
```yaml
# ❌ Wrong - missing quotes for special characters
path: /usr/local/bin
version: 2.1.0
regex: ^[a-zA-Z0-9]+$
message: Hello\nWorld

# ✅ Correct - use quotes when needed
path: '/usr/local/bin'
version: '2.1.0'
regex: '^[a-zA-Z0-9]+$'
message: "Hello\nWorld"
```

### 3. Incorrect Quote Type
```yaml
# ❌ Wrong - using single quotes for escape sequences
message: 'Hello\nWorld'  # \n won't be interpreted
path: 'C:\Users\John'    # \U won't be interpreted

# ✅ Correct - use double quotes for escape sequences
message: "Hello\nWorld"
path: "C:\\Users\\John"
```

## 📋 Best Practices

### 1. Use No Quotes for Simple Values
```yaml
# Good - no quotes for simple values
application:
  name: myapp
  version: 2.1.0
  debug: false
  port: 3000
  timeout: 30
  max_connections: 100
```

### 2. Use Single Quotes for Paths and URLs
```yaml
# Good - single quotes for paths and URLs
paths:
  config_file: '/etc/myapp/config.yml'
  log_file: '/var/log/myapp/app.log'
  database_url: 'postgresql://user:pass@localhost:5432/myapp'
  api_endpoint: 'https://api.example.com/v1'
  ssl_cert: '/etc/ssl/certs/myapp.crt'
```

### 3. Use Double Quotes for Escape Sequences
```yaml
# Good - double quotes for escape sequences
messages:
  welcome: "Welcome to MyApp!\nPlease log in to continue."
  error: "Error: \"Invalid credentials\""
  success: "Success! Your changes have been saved."
  regex: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
```

### 4. Be Consistent Within Files
```yaml
# Good - consistent quoting style
database:
  host: localhost
  port: 5432
  name: myapp
  user: db_user
  password: "{{ vault_db_password }}"
  connection_string: 'postgresql://user:pass@localhost:5432/myapp'
  ssl_cert: '/etc/ssl/certs/db.crt'
  ssl_key: '/etc/ssl/private/db.key'
```

### 5. Use Quotes for Ambiguous Values
```yaml
# Good - quotes for potentially ambiguous values
settings:
  # These could be interpreted as numbers or booleans
  version: '2.1.0'
  debug: 'false'
  port: '3000'
  
  # These are clearly strings
  name: myapp
  environment: production
  timeout: 30
```

## 🔍 Working with Quoted Strings

### Python Example
```python
import yaml

# Load YAML with different quote styles
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

# Access quoted and unquoted values
print(f"Name: {config['name']}")
print(f"Version: {config['version']}")
print(f"Path: {config['path']}")
print(f"Message: {config['message']}")

# Handle different quote styles
def process_config_value(value):
    """Process configuration values with different quote styles."""
    if isinstance(value, str):
        # Handle escape sequences in double-quoted strings
        return value.replace('\\n', '\n').replace('\\t', '\t')
    return value
```

### JavaScript Example
```javascript
const yaml = require('js-yaml');
const fs = require('fs');

// Load YAML
const config = yaml.load(fs.readFileSync('config.yaml', 'utf8'));

// Access quoted and unquoted values
console.log(`Name: ${config.name}`);
console.log(`Version: ${config.version}`);
console.log(`Path: ${config.path}`);
console.log(`Message: ${config.message}`);

// Handle different quote styles
function processConfigValue(value) {
    if (typeof value === 'string') {
        // Handle escape sequences in double-quoted strings
        return value.replace(/\\n/g, '\n').replace(/\\t/g, '\t');
    }
    return value;
}
```

## 🎯 Key Takeaways

- **No quotes** for simple strings, numbers, booleans
- **Single quotes (`'`)** for paths, URLs, and strings with spaces
- **Double quotes (`"`)** for strings with escape sequences
- **Be consistent** with quoting style within files
- **Use quotes** when there's ambiguity
- **Consider readability** when choosing quote style

## 📚 Next Steps

After mastering quoting rules, explore:
- [Basic Syntax](./../basic-syntax/README.md) - Review fundamentals
- [Scalars](./../scalars/README.md) - Understanding data types
- [Multiline Strings](./../multiline-strings/README.md) - Handling text content 