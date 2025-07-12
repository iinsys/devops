# YAML Lists (Arrays)

Lists in YAML are sequences of items, similar to arrays in programming languages. They are created using the `-` (dash) character and are essential for representing collections of data.

## 📋 List Basics

### Simple Lists
```yaml
# List of strings
fruits:
  - apple
  - banana
  - orange
  - grape

# List of numbers
numbers:
  - 1
  - 2
  - 3
  - 4
  - 5

# List of booleans
flags:
  - true
  - false
  - true
```

### Inline Lists
```yaml
# Compact inline format
colors: [red, blue, green, yellow]
scores: [85, 92, 78, 96]
enabled: [true, false, true]
```

## 🔧 Real-World Examples

### Docker Compose Services
```yaml
# docker-compose.yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./html:/usr/share/nginx/html
      - ./logs:/var/log/nginx
    environment:
      - NGINX_HOST=localhost
      - NGINX_PORT=80
```

### Kubernetes Pod Configuration
```yaml
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
    - containerPort: 443
    env:
    - name: NGINX_HOST
      value: "localhost"
    - name: NGINX_PORT
      value: "80"
```

### Ansible Playbook Tasks
```yaml
# playbook.yaml
---
- name: Configure web server
  hosts: webservers
  become: yes
  tasks:
    - name: Install required packages
      apt:
        name:
          - nginx
          - apache2-utils
          - certbot
        state: present
    - name: Start and enable services
      service:
        name: "{{ item }}"
        state: started
        enabled: yes
      loop:
        - nginx
        - certbot
```

## 🧩 Complex List Examples

### List of Dictionaries
```yaml
# users.yaml
users:
  - name: John Doe
    email: john@example.com
    role: admin
    active: true
  - name: Jane Smith
    email: jane@example.com
    role: user
    active: true
  - name: Bob Wilson
    email: bob@example.com
    role: user
    active: false
```

### Configuration with Lists
```yaml
# app-config.yaml
application:
  name: "My App"
  features:
    - authentication
    - logging
    - monitoring
    - caching
  allowed_origins:
    - "https://app.example.com"
    - "https://admin.example.com"
    - "http://localhost:3000"
  database:
    hosts:
      - "db1.example.com:5432"
      - "db2.example.com:5432"
      - "db3.example.com:5432"
```

### API Endpoints Configuration
```yaml
# api-endpoints.yaml
api:
  version: "v1"
  endpoints:
    - path: "/users"
      method: "GET"
      description: "List all users"
    - path: "/users/{id}"
      method: "GET"
      description: "Get user by ID"
    - path: "/users"
      method: "POST"
      description: "Create new user"
    - path: "/users/{id}"
      method: "PUT"
      description: "Update user"
    - path: "/users/{id}"
      method: "DELETE"
      description: "Delete user"
```

## ⚠️ Common Mistakes

### 1. Incorrect Indentation
```yaml
# ❌ Wrong - inconsistent indentation
fruits:
- apple
  - banana
- orange

# ✅ Correct - consistent indentation
fruits:
  - apple
  - banana
  - orange
```

### 2. Missing Dash
```yaml
# ❌ Wrong - missing dash for list items
fruits:
  apple
  banana
  orange

# ✅ Correct - using dash for list items
fruits:
  - apple
  - banana
  - orange
```

### 3. Mixed Content Types
```yaml
# ❌ Avoid mixing types in the same list
mixed_list:
  - "string"
  - 123
  - true
  - null

# ✅ Better - use consistent types
strings:
  - "string1"
  - "string2"
numbers:
  - 123
  - 456
```

## 🧪 Advanced Examples

### Environment Configuration
```yaml
# environments.yaml
environments:
  development:
    databases:
      - name: "dev_db"
        host: "localhost"
        port: 5432
      - name: "test_db"
        host: "localhost"
        port: 5433
    services:
      - name: "web"
        port: 3000
      - name: "api"
        port: 3001
      - name: "worker"
        port: 3002

  production:
    databases:
      - name: "prod_db"
        host: "prod-db.example.com"
        port: 5432
    services:
      - name: "web"
        port: 80
      - name: "api"
        port: 443
```

### Monitoring Configuration
```yaml
# monitoring.yaml
monitoring:
  metrics:
    - name: "cpu_usage"
      type: "gauge"
      interval: 60
    - name: "memory_usage"
      type: "gauge"
      interval: 60
    - name: "disk_usage"
      type: "gauge"
      interval: 300
    - name: "http_requests"
      type: "counter"
      interval: 10

  alerts:
    - name: "high_cpu"
      condition: "cpu_usage > 90"
      duration: "5m"
    - name: "high_memory"
      condition: "memory_usage > 85"
      duration: "3m"
    - name: "disk_full"
      condition: "disk_usage > 95"
      duration: "1m"
```

### CI/CD Pipeline
```yaml
# pipeline.yaml
pipeline:
  stages:
    - name: "build"
      jobs:
        - name: "compile"
          script: "make build"
        - name: "test"
          script: "make test"
        - name: "lint"
          script: "make lint"

    - name: "deploy"
      jobs:
        - name: "deploy_staging"
          script: "deploy.sh staging"
        - name: "deploy_production"
          script: "deploy.sh production"
          when: "manual"
```

## 📋 Best Practices

### 1. Consistent Indentation
```yaml
# Always use 2 spaces for list indentation
items:
  - first_item
  - second_item
  - third_item
```

### 2. Use Descriptive Names
```yaml
# Good naming
allowed_ips:
  - "192.168.1.100"
  - "192.168.1.101"

# Avoid generic names
ips:
  - "192.168.1.100"
  - "192.168.1.101"
```

### 3. Group Related Items
```yaml
# Group related configurations
database:
  primary_hosts:
    - "db1.example.com"
    - "db2.example.com"
  replica_hosts:
    - "db3.example.com"
    - "db4.example.com"
```

### 4. Use Comments for Clarity
```yaml
# List of production servers
production_servers:
  - "web1.prod.example.com"    # Primary web server
  - "web2.prod.example.com"    # Secondary web server
  - "api1.prod.example.com"    # Primary API server
  - "api2.prod.example.com"    # Secondary API server
```

## 🔍 List Operations

### Python Example
```python
import yaml

# Load YAML with lists
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

# Access list items
fruits = config['fruits']
print(f"First fruit: {fruits[0]}")
print(f"Number of fruits: {len(fruits)}")

# Iterate through list
for fruit in fruits:
    print(f"Fruit: {fruit}")

# List comprehension
capitalized_fruits = [fruit.upper() for fruit in fruits]
```

### JavaScript Example
```javascript
const yaml = require('js-yaml');
const fs = require('fs');

// Load YAML
const config = yaml.load(fs.readFileSync('config.yaml', 'utf8'));

// Access list items
const fruits = config.fruits;
console.log(`First fruit: ${fruits[0]}`);
console.log(`Number of fruits: ${fruits.length}`);

// Iterate through list
fruits.forEach(fruit => {
    console.log(`Fruit: ${fruit}`);
});

// Map over list
const capitalizedFruits = fruits.map(fruit => fruit.toUpperCase());
```

## 🎯 Key Takeaways

- **Use `-` (dash)** to create list items
- **Consistent indentation** is crucial (2 spaces)
- **Lists can contain** any YAML data type
- **Inline lists** use `[item1, item2, item3]` syntax
- **Lists are ordered** - order matters
- **Use descriptive names** for list variables

## 📚 Next Steps

After mastering lists, explore:
- [Dictionaries](./../dictionaries/README.md) - Key-value structures
- [Nested Structures](./../nested-structures/README.md) - Combining lists and dictionaries
- [Multiline Strings](./../multiline-strings/README.md) - Handling text content 