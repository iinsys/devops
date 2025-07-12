# YAML Multiline Strings

Multiline strings in YAML allow you to handle text content that spans multiple lines while preserving formatting. YAML provides different block scalar styles for different use cases.

## 📝 Multiline String Basics

### Literal Block Scalar (`|`)
Preserves line breaks and indentation exactly as written.

```yaml
# Using literal block scalar (|)
script: |
  #!/bin/bash
  echo "Starting application..."
  
  # Check if database is ready
  while ! nc -z database 5432; do
    echo "Waiting for database..."
    sleep 2
  done
  
  # Start the application
  python app.py
```

### Folded Block Scalar (`>`)
Folds line breaks to spaces, but preserves paragraph breaks.

```yaml
# Using folded block scalar (>)
description: >
  This is a long description that spans multiple lines.
  Line breaks are converted to spaces, making it a single paragraph.
  
  This creates a new paragraph because of the blank line.
```

## 🔧 Real-World Examples

### Docker Compose with Scripts
```yaml
# docker-compose.yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    container_name: web-server
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    command: |
      /bin/bash -c "
      echo 'Starting nginx...'
      nginx -g 'daemon off;'
      "

  app:
    image: node:16-alpine
    container_name: app-server
    working_dir: /app
    volumes:
      - ./app:/app
    environment:
      NODE_ENV: production
    command: |
      sh -c "
      npm install
      npm start
      "
```

### Kubernetes ConfigMap with Scripts
```yaml
# configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  nginx.conf: |
    server {
        listen 80;
        server_name localhost;
        
        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
        }
        
        location /api {
            proxy_pass http://backend:3000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }

  startup.sh: |
    #!/bin/bash
    set -e
    
    echo "Starting application..."
    
    # Wait for database
    echo "Waiting for database..."
    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 2
    done
    
    # Run migrations
    echo "Running migrations..."
    python manage.py migrate
    
    # Start application
    echo "Starting application..."
    python manage.py runserver 0.0.0.0:8000
```

### Ansible Playbook with Templates
```yaml
# playbook.yaml
---
- name: Configure web server
  hosts: webservers
  become: yes
  tasks:
    - name: Create nginx configuration
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/myapp
        mode: '0644'
      notify: restart nginx

    - name: Create application script
      copy:
        content: |
          #!/bin/bash
          # Application startup script
          
          # Set environment
          export NODE_ENV=production
          export PORT=3000
          
          # Install dependencies
          npm install --production
          
          # Start application
          npm start
        dest: /opt/myapp/start.sh
        mode: '0755'
        owner: www-data
        group: www-data

    - name: Create systemd service
      template:
        src: myapp.service.j2
        dest: /etc/systemd/system/myapp.service
        mode: '0644'
      notify: restart myapp

  handlers:
    - name: restart nginx
      systemd:
        name: nginx
        state: restarted

    - name: restart myapp
      systemd:
        name: myapp
        state: restarted
```

## 🧩 Advanced Examples

### Complex Application Configuration
```yaml
# app-config.yaml
application:
  name: "My Web Application"
  version: "2.1.0"
  
  # Database configuration
  database:
    host: "localhost"
    port: 5432
    name: "myapp"
    connection_string: |
      postgresql://user:password@localhost:5432/myapp
      ?sslmode=require&connect_timeout=10

  # Logging configuration
  logging:
    level: "info"
    format: |
      {
        "timestamp": "%(asctime)s",
        "level": "%(levelname)s",
        "message": "%(message)s",
        "service": "myapp"
      }
    file: "/var/log/myapp/app.log"

  # API documentation
  api_docs: |
    # API Documentation
    
    ## Authentication
    
    All API endpoints require authentication using Bearer tokens.
    
    ```bash
    curl -H "Authorization: Bearer <token>" \
         https://api.example.com/v1/users
    ```
    
    ## Endpoints
    
    ### GET /users
    Returns a list of all users.
    
    ### POST /users
    Creates a new user.
    
    ### GET /users/{id}
    Returns a specific user by ID.

  # Shell script for deployment
  deploy_script: |
    #!/bin/bash
    set -e
    
    echo "Starting deployment..."
    
    # Backup current version
    if [ -d "/opt/myapp/current" ]; then
      echo "Backing up current version..."
      cp -r /opt/myapp/current /opt/myapp/backup/$(date +%Y%m%d_%H%M%S)
    fi
    
    # Deploy new version
    echo "Deploying new version..."
    cp -r /opt/myapp/releases/latest /opt/myapp/current
    
    # Run database migrations
    echo "Running migrations..."
    cd /opt/myapp/current
    python manage.py migrate
    
    # Restart services
    echo "Restarting services..."
    systemctl restart myapp
    systemctl restart nginx
    
    echo "Deployment completed successfully!"
```

### Infrastructure Configuration
```yaml
# infrastructure.yaml
infrastructure:
  # Terraform configuration
  terraform_config: |
    # Configure the AWS Provider
    provider "aws" {
      region = "us-west-2"
    }
    
    # Create VPC
    resource "aws_vpc" "main" {
      cidr_block = "10.0.0.0/16"
      
      tags = {
        Name = "main"
        Environment = "production"
      }
    }
    
    # Create subnets
    resource "aws_subnet" "public" {
      vpc_id     = aws_vpc.main.id
      cidr_block = "10.0.1.0/24"
      
      tags = {
        Name = "public"
      }
    }

  # Docker Compose configuration
  docker_compose: |
    version: '3.8'
    services:
      web:
        image: nginx:latest
        ports:
          - "80:80"
        volumes:
          - ./html:/usr/share/nginx/html
      
      api:
        image: node:16-alpine
        working_dir: /app
        volumes:
          - ./api:/app
        ports:
          - "3000:3000"
        environment:
          NODE_ENV: production
          DATABASE_URL: postgresql://user:pass@db:5432/myapp

  # Kubernetes deployment
  k8s_deployment: |
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: myapp
      labels:
        app: myapp
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: myapp
      template:
        metadata:
          labels:
            app: myapp
        spec:
          containers:
          - name: myapp
            image: myapp:latest
            ports:
            - containerPort: 3000
            env:
            - name: NODE_ENV
              value: "production"
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: db-secret
                  key: url
```

## ⚠️ Common Mistakes

### 1. Incorrect Indentation in Block Scalars
```yaml
# ❌ Wrong - inconsistent indentation
script: |
  #!/bin/bash
echo "Hello World"  # Wrong indentation
  echo "Goodbye"    # Wrong indentation

# ✅ Correct - consistent indentation
script: |
  #!/bin/bash
  echo "Hello World"
  echo "Goodbye"
```

### 2. Mixing Block Scalar Styles
```yaml
# ❌ Wrong - mixing styles inappropriately
description: |
  This is a description
  that should be folded
  into a single line

# ✅ Correct - use folded scalar for descriptions
description: >
  This is a description
  that should be folded
  into a single line
```

### 3. Not Preserving Important Whitespace
```yaml
# ❌ Wrong - losing important formatting
code: |
  def hello():
  print("Hello")
  return True

# ✅ Correct - preserve important formatting
code: |
  def hello():
      print("Hello")
      return True
```

## 📋 Best Practices

### 1. Choose the Right Block Scalar Style
```yaml
# Use literal (|) for scripts and code
script: |
  #!/bin/bash
  echo "Starting application..."
  python app.py

# Use folded (>) for descriptions and documentation
description: >
  This is a long description that should be
  folded into a single paragraph for better
  readability in the final output.

# Use plain strings for short content
short_text: "This is a short string"
```

### 2. Maintain Consistent Indentation
```yaml
# Good indentation
configuration:
  script: |
    #!/bin/bash
    set -e
    
    echo "Starting..."
    python app.py
    
  description: >
    This is a description
    that spans multiple lines
    but folds into one paragraph.
```

### 3. Use Comments for Complex Content
```yaml
# Complex configuration with comments
application:
  # Database connection script
  db_script: |
    #!/bin/bash
    # Wait for database to be ready
    while ! nc -z $DB_HOST $DB_PORT; do
      echo "Waiting for database..."
      sleep 2
    done
    
    # Run migrations
    python manage.py migrate
    
  # Application configuration template
  config_template: |
    # Application configuration
    [database]
    host = {{ db_host }}
    port = {{ db_port }}
    name = {{ db_name }}
    
    [logging]
    level = {{ log_level }}
    file = {{ log_file }}
```

### 4. Handle Special Characters Properly
```yaml
# Proper handling of special characters
configuration:
  # Use quotes for strings with special characters
  regex_pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
  
  # Use literal scalar for scripts with special characters
  script: |
    #!/bin/bash
    # Handle special characters in paths
    cd /opt/myapp
    ./bin/start.sh --config=/etc/myapp/config.yml
```

## 🔍 Working with Multiline Strings

### Python Example
```python
import yaml

# Load YAML with multiline strings
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

# Access multiline strings
script = config['script']
print("Script content:")
print(script)

# Process multiline content
lines = script.split('\n')
for i, line in enumerate(lines, 1):
    print(f"Line {i}: {line}")
```

### JavaScript Example
```javascript
const yaml = require('js-yaml');
const fs = require('fs');

// Load YAML
const config = yaml.load(fs.readFileSync('config.yaml', 'utf8'));

// Access multiline strings
const script = config.script;
console.log('Script content:');
console.log(script);

// Process multiline content
const lines = script.split('\n');
lines.forEach((line, index) => {
    console.log(`Line ${index + 1}: ${line}`);
});
```

## 🎯 Key Takeaways

- **Use `|` (literal)** for scripts, code, and content where line breaks matter
- **Use `>` (folded)** for descriptions and text that should flow as paragraphs
- **Maintain consistent indentation** within block scalars
- **Use quotes** for strings with special characters
- **Choose the right style** based on your content needs
- **Preserve important formatting** in scripts and code

## 📚 Next Steps

After mastering multiline strings, explore:
- [Comments](./../comments/README.md) - Documentation and clarity
- [Quoting Rules](./../quoting-rules/README.md) - Advanced string handling
- [Basic Syntax](./../basic-syntax/README.md) - Review fundamentals 