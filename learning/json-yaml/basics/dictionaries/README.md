# YAML Dictionaries (Maps)

Dictionaries in YAML are key-value pairs, similar to objects in JavaScript or dictionaries in Python. They are created using the `:` (colon) character and are fundamental for organizing structured data.

## 🗂️ Dictionary Basics

### Simple Dictionaries
```yaml
# Basic key-value pairs
person:
  name: John Doe
  age: 30
  email: john@example.com
  active: true

# Inline dictionary format
person: {name: John Doe, age: 30, email: john@example.com, active: true}
```

### Nested Dictionaries
```yaml
# Dictionary with nested structure
user:
  personal_info:
    name: John Doe
    age: 30
    email: john@example.com
  address:
    street: 123 Main St
    city: New York
    zip: 10001
    country: USA
  preferences:
    theme: dark
    notifications: true
    language: en
```

## 🔧 Real-World Examples

### Kubernetes Deployment
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
    environment: production
    version: v1.0.0
spec:
  replicas: 3
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
        env:
        - name: NGINX_HOST
          value: "localhost"
        - name: NGINX_PORT
          value: "80"
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"
            cpu: "500m"
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
      NGINX_HOST: localhost
      NGINX_PORT: 80
    volumes:
      - ./html:/usr/share/nginx/html
      - ./logs:/var/log/nginx
    networks:
      - frontend
      - backend
    depends_on:
      - database
    restart: unless-stopped

  database:
    image: postgres:13
    container_name: postgres-db
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: secret123
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - backend
    ports:
      - "5432:5432"

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge

volumes:
  postgres_data:
    driver: local
```

### Ansible Variables
```yaml
# vars.yaml
---
# Database configuration
database:
  host: "db.example.com"
  port: 5432
  name: "myapp"
  user: "db_user"
  password: "{{ vault_db_password }}"
  ssl: true
  connection_timeout: 30

# Application settings
application:
  name: "My Web Application"
  version: "2.1.0"
  debug: false
  log_level: "info"
  max_workers: 4
  timeout: 60

# Environment-specific settings
environments:
  development:
    database:
      host: "localhost"
      port: 5432
    application:
      debug: true
      log_level: "debug"
  
  production:
    database:
      host: "prod-db.example.com"
      port: 5432
    application:
      debug: false
      log_level: "warn"
```

## 🧩 Complex Dictionary Examples

### API Configuration
```yaml
# api-config.yaml
api:
  version: "v1"
  base_url: "https://api.example.com"
  timeout: 30
  rate_limit: 1000
  authentication:
    type: "bearer"
    token_expiry: 3600
    refresh_threshold: 300
  endpoints:
    users:
      path: "/users"
      methods: ["GET", "POST"]
      rate_limit: 100
    user_details:
      path: "/users/{id}"
      methods: ["GET", "PUT", "DELETE"]
      rate_limit: 50
  security:
    cors:
      allowed_origins:
        - "https://app.example.com"
        - "https://admin.example.com"
    headers:
      - "Authorization"
      - "Content-Type"
      - "X-API-Key"
```

### Monitoring Configuration
```yaml
# monitoring.yaml
monitoring:
  enabled: true
  interval: 60
  retention_days: 30
  metrics:
    cpu:
      enabled: true
      threshold: 90
      alert: true
    memory:
      enabled: true
      threshold: 85
      alert: true
    disk:
      enabled: true
      threshold: 95
      alert: true
    network:
      enabled: false
      threshold: 80
      alert: false
  alerts:
    email:
      enabled: true
      recipients:
        - "admin@example.com"
        - "ops@example.com"
    slack:
      enabled: true
      webhook_url: "{{ vault_slack_webhook }}"
      channel: "#alerts"
    webhook:
      enabled: false
      url: null
  dashboards:
    - name: "System Overview"
      url: "https://grafana.example.com/d/system"
    - name: "Application Metrics"
      url: "https://grafana.example.com/d/app"
```

### CI/CD Pipeline Configuration
```yaml
# pipeline-config.yaml
pipeline:
  name: "My Application Pipeline"
  version: "1.0"
  triggers:
    - type: "push"
      branches: ["main", "develop"]
    - type: "pull_request"
      branches: ["main"]
  stages:
    build:
      name: "Build"
      timeout: 10
      parallel: false
      jobs:
        - name: "compile"
          script: "make build"
          artifacts:
            - "dist/*"
        - name: "test"
          script: "make test"
          coverage: true
    deploy:
      name: "Deploy"
      timeout: 15
      parallel: false
      jobs:
        - name: "deploy_staging"
          script: "deploy.sh staging"
          environment: "staging"
        - name: "deploy_production"
          script: "deploy.sh production"
          environment: "production"
          when: "manual"
  environments:
    staging:
      url: "https://staging.example.com"
      auto_deploy: true
    production:
      url: "https://app.example.com"
      auto_deploy: false
```

## ⚠️ Common Mistakes

### 1. Missing Spaces After Colon
```yaml
# ❌ Wrong - no space after colon
name:John Doe
age:30

# ✅ Correct - space after colon
name: John Doe
age: 30
```

### 2. Inconsistent Indentation
```yaml
# ❌ Wrong - inconsistent indentation
person:
  name: John Doe
age: 30  # Wrong indentation level

# ✅ Correct - consistent indentation
person:
  name: John Doe
  age: 30
```

### 3. Using Tabs Instead of Spaces
```yaml
# ❌ Wrong - using tabs
person:
	name: John Doe
	age: 30

# ✅ Correct - using 2 spaces
person:
  name: John Doe
  age: 30
```

## 🧪 Advanced Examples

### Multi-Environment Configuration
```yaml
# environments.yaml
environments:
  development:
    database:
      host: "localhost"
      port: 5432
      name: "dev_db"
      user: "dev_user"
      password: "dev_pass"
    application:
      debug: true
      log_level: "debug"
      port: 3000
    features:
      authentication: true
      logging: true
      monitoring: false
      caching: false

  staging:
    database:
      host: "staging-db.example.com"
      port: 5432
      name: "staging_db"
      user: "staging_user"
      password: "{{ vault_staging_password }}"
    application:
      debug: false
      log_level: "info"
      port: 80
    features:
      authentication: true
      logging: true
      monitoring: true
      caching: true

  production:
    database:
      host: "prod-db.example.com"
      port: 5432
      name: "prod_db"
      user: "prod_user"
      password: "{{ vault_prod_password }}"
    application:
      debug: false
      log_level: "warn"
      port: 443
    features:
      authentication: true
      logging: true
      monitoring: true
      caching: true
```

### Service Discovery Configuration
```yaml
# service-discovery.yaml
services:
  web:
    name: "web-service"
    version: "2.1.0"
    endpoints:
      - name: "health"
        path: "/health"
        method: "GET"
        port: 8080
      - name: "metrics"
        path: "/metrics"
        method: "GET"
        port: 8080
    health_check:
      path: "/health"
      interval: 30
      timeout: 5
      retries: 3
    load_balancer:
      algorithm: "round_robin"
      health_check: true
      sticky_sessions: false

  api:
    name: "api-service"
    version: "1.5.0"
    endpoints:
      - name: "users"
        path: "/api/v1/users"
        method: "GET"
        port: 3000
      - name: "user_details"
        path: "/api/v1/users/{id}"
        method: "GET"
        port: 3000
    health_check:
      path: "/health"
      interval: 30
      timeout: 5
      retries: 3
    load_balancer:
      algorithm: "least_connections"
      health_check: true
      sticky_sessions: true
```

## 📋 Best Practices

### 1. Use Descriptive Key Names
```yaml
# Good naming
user_authentication_settings:
  session_timeout_minutes: 30
  max_login_attempts: 5
  password_minimum_length: 8

# Avoid generic names
settings:
  timeout: 30
  attempts: 5
  length: 8
```

### 2. Group Related Data
```yaml
# Logical grouping
application:
  database:
    host: "localhost"
    port: 5432
  cache:
    redis_host: "localhost"
    redis_port: 6379
  logging:
    level: "info"
    file: "/var/log/app.log"
```

### 3. Use Comments for Documentation
```yaml
# Application configuration
application:
  # Database connection settings
  database:
    host: "localhost"      # Database host
    port: 5432            # Database port
    name: "myapp"         # Database name
  
  # Cache configuration
  cache:
    enabled: true         # Enable caching
    ttl: 3600            # Time to live in seconds
    max_size: 100        # Maximum cache size
```

### 4. Handle Sensitive Data Properly
```yaml
# Use variables for sensitive data
database:
  host: "{{ db_host }}"
  port: "{{ db_port }}"
  user: "{{ db_user }}"
  password: "{{ vault_db_password }}"  # Use vault for secrets
```

## 🔍 Dictionary Operations

### Python Example
```python
import yaml

# Load YAML with dictionaries
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

# Access dictionary values
person = config['person']
print(f"Name: {person['name']}")
print(f"Age: {person['age']}")

# Iterate through dictionary
for key, value in person.items():
    print(f"{key}: {value}")

# Nested dictionary access
address = person['address']
print(f"City: {address['city']}")
```

### JavaScript Example
```javascript
const yaml = require('js-yaml');
const fs = require('fs');

// Load YAML
const config = yaml.load(fs.readFileSync('config.yaml', 'utf8'));

// Access dictionary values
const person = config.person;
console.log(`Name: ${person.name}`);
console.log(`Age: ${person.age}`);

// Iterate through dictionary
Object.entries(person).forEach(([key, value]) => {
    console.log(`${key}: ${value}`);
});

// Nested dictionary access
const address = person.address;
console.log(`City: ${address.city}`);
```

## 🎯 Key Takeaways

- **Use `:` (colon)** to create key-value pairs
- **Consistent indentation** is crucial (2 spaces)
- **Dictionaries can be nested** to any depth
- **Keys are unique** within the same level
- **Use descriptive names** for keys
- **Group related data** logically

## 📚 Next Steps

After mastering dictionaries, explore:
- [Nested Structures](./../nested-structures/README.md) - Combining lists and dictionaries
- [Multiline Strings](./../multiline-strings/README.md) - Handling text content
- [Comments](./../comments/README.md) - Documentation and clarity 