# YAML Nested Structures

Nested structures in YAML combine lists and dictionaries to create complex, hierarchical data structures. This is where YAML's power truly shines for representing real-world data relationships.

## 🏗️ Nested Structure Basics

### List of Dictionaries
```yaml
# List containing multiple dictionaries
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

### Dictionary of Lists
```yaml
# Dictionary containing multiple lists
application:
  features:
    - authentication
    - logging
    - monitoring
    - caching
  allowed_ips:
    - "192.168.1.100"
    - "192.168.1.101"
    - "10.0.0.50"
  databases:
    - name: "primary"
      host: "db1.example.com"
      port: 5432
    - name: "replica"
      host: "db2.example.com"
      port: 5432
```

### Complex Nested Structure
```yaml
# Deeply nested structure
company:
  name: "TechCorp"
  departments:
    engineering:
      name: "Engineering"
      employees:
        - name: "Alice Johnson"
          position: "Senior Developer"
          skills:
            - "Python"
            - "JavaScript"
            - "Docker"
          projects:
            - name: "Web App"
              status: "active"
            - name: "API Service"
              status: "completed"
        - name: "Bob Smith"
          position: "DevOps Engineer"
          skills:
            - "Kubernetes"
            - "Terraform"
            - "AWS"
          projects:
            - name: "Infrastructure"
              status: "active"
    marketing:
      name: "Marketing"
      employees:
        - name: "Carol Davis"
          position: "Marketing Manager"
          campaigns:
            - name: "Summer Sale"
              budget: 50000
              status: "active"
```

## 🔧 Real-World Examples

### Kubernetes Multi-Container Pod
```yaml
# multi-container-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app-pod
  labels:
    app: web-app
    environment: production
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
          name: http
        - containerPort: 443
          name: https
      volumeMounts:
        - name: nginx-config
          mountPath: /etc/nginx/conf.d
        - name: web-content
          mountPath: /usr/share/nginx/html
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

    - name: sidecar
      image: busybox:latest
      command: ["/bin/sh"]
      args: ["-c", "while true; do echo 'Sidecar running'; sleep 30; done"]
      volumeMounts:
        - name: shared-logs
          mountPath: /var/log

  volumes:
    - name: nginx-config
      configMap:
        name: nginx-config
    - name: web-content
      emptyDir: {}
    - name: shared-logs
      emptyDir: {}
```

### Docker Compose with Multiple Services
```yaml
# complex-docker-compose.yaml
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
      - ./ssl:/etc/nginx/ssl
    networks:
      - frontend
      - backend
    depends_on:
      - api
      - database
    restart: unless-stopped
    deploy:
      replicas: 2
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M

  api:
    image: node:16-alpine
    container_name: api-server
    working_dir: /app
    volumes:
      - ./api:/app
      - /app/node_modules
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
      DATABASE_URL: postgresql://user:pass@database:5432/myapp
      REDIS_URL: redis://cache:6379
    networks:
      - backend
    depends_on:
      - database
      - cache
    deploy:
      replicas: 3
      resources:
        limits:
          cpus: '1.0'
          memory: 1G

  database:
    image: postgres:13
    container_name: postgres-db
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_INITDB_ARGS: "--encoding=UTF-8 --lc-collate=C --lc-ctype=C"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init-scripts:/docker-entrypoint-initdb.d
    networks:
      - backend
    ports:
      - "5432:5432"
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 2G

  cache:
    image: redis:6-alpine
    container_name: redis-cache
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    networks:
      - backend
    ports:
      - "6379:6379"
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M

  monitoring:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    networks:
      - monitoring
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=200h'
      - '--web.enable-lifecycle'

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
  monitoring:
    driver: bridge

volumes:
  postgres_data:
    driver: local
  redis_data:
    driver: local
  prometheus_data:
    driver: local
```

### Ansible Complex Playbook
```yaml
# complex-playbook.yaml
---
- name: Deploy Multi-Tier Application
  hosts: all
  become: yes
  vars:
    app_name: "myapp"
    app_version: "2.1.0"
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
    - name: Install system packages
      apt:
        name:
          - nginx
          - postgresql-client
          - redis-tools
          - curl
          - wget
        state: present
        update_cache: yes

    - name: Create application directories
      file:
        path: "{{ item }}"
        state: directory
        mode: '0755'
        owner: "{{ app_user }}"
        group: "{{ app_group }}"
      loop:
        - "/opt/{{ app_name }}"
        - "/opt/{{ app_name }}/logs"
        - "/opt/{{ app_name }}/config"
        - "/opt/{{ app_name }}/data"

    - name: Configure application services
      template:
        src: "{{ item.src }}"
        dest: "{{ item.dest }}"
        mode: '0644'
        owner: "{{ app_user }}"
        group: "{{ app_group }}"
      loop:
        - src: "nginx.conf.j2"
          dest: "/etc/nginx/sites-available/{{ app_name }}"
        - src: "app.config.j2"
          dest: "/opt/{{ app_name }}/config/app.conf"
        - src: "systemd.service.j2"
          dest: "/etc/systemd/system/{{ app_name }}.service"

    - name: Enable and start services
      systemd:
        name: "{{ item }}"
        state: started
        enabled: yes
        daemon_reload: yes
      loop:
        - nginx
        - "{{ app_name }}"

    - name: Configure monitoring
      block:
        - name: Install monitoring tools
          apt:
            name:
              - prometheus
              - grafana
            state: present

        - name: Configure Prometheus
          template:
            src: "prometheus.yml.j2"
            dest: "/etc/prometheus/prometheus.yml"
            mode: '0644'
            owner: prometheus
            group: prometheus
          notify: restart prometheus

        - name: Configure Grafana
          template:
            src: "grafana.ini.j2"
            dest: "/etc/grafana/grafana.ini"
            mode: '0644'
            owner: grafana
            group: grafana
          notify: restart grafana

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

## 🧩 Advanced Nested Examples

### Microservices Configuration
```yaml
# microservices-config.yaml
microservices:
  user_service:
    name: "user-service"
    version: "1.2.0"
    endpoints:
      - path: "/users"
        method: "GET"
        description: "List all users"
        rate_limit: 100
        authentication: true
      - path: "/users/{id}"
        method: "GET"
        description: "Get user by ID"
        rate_limit: 50
        authentication: true
      - path: "/users"
        method: "POST"
        description: "Create new user"
        rate_limit: 10
        authentication: true
    dependencies:
      - name: "database"
        type: "postgresql"
        host: "user-db.example.com"
        port: 5432
      - name: "cache"
        type: "redis"
        host: "cache.example.com"
        port: 6379
    health_check:
      path: "/health"
      interval: 30
      timeout: 5
      retries: 3
    scaling:
      min_replicas: 2
      max_replicas: 10
      target_cpu_utilization: 70

  order_service:
    name: "order-service"
    version: "1.1.0"
    endpoints:
      - path: "/orders"
        method: "GET"
        description: "List all orders"
        rate_limit: 200
        authentication: true
      - path: "/orders/{id}"
        method: "GET"
        description: "Get order by ID"
        rate_limit: 100
        authentication: true
      - path: "/orders"
        method: "POST"
        description: "Create new order"
        rate_limit: 50
        authentication: true
    dependencies:
      - name: "database"
        type: "postgresql"
        host: "order-db.example.com"
        port: 5432
      - name: "message_queue"
        type: "rabbitmq"
        host: "mq.example.com"
        port: 5672
    health_check:
      path: "/health"
      interval: 30
      timeout: 5
      retries: 3
    scaling:
      min_replicas: 3
      max_replicas: 15
      target_cpu_utilization: 80

  payment_service:
    name: "payment-service"
    version: "1.0.0"
    endpoints:
      - path: "/payments"
        method: "POST"
        description: "Process payment"
        rate_limit: 20
        authentication: true
      - path: "/payments/{id}"
        method: "GET"
        description: "Get payment status"
        rate_limit: 100
        authentication: true
    dependencies:
      - name: "database"
        type: "postgresql"
        host: "payment-db.example.com"
        port: 5432
      - name: "external_api"
        type: "stripe"
        url: "https://api.stripe.com"
    health_check:
      path: "/health"
      interval: 30
      timeout: 5
      retries: 3
    scaling:
      min_replicas: 2
      max_replicas: 8
      target_cpu_utilization: 60
```

### Infrastructure as Code Configuration
```yaml
# infrastructure-config.yaml
infrastructure:
  environments:
    development:
      vpc:
        cidr: "10.0.0.0/16"
        subnets:
          - name: "public-1"
            cidr: "10.0.1.0/24"
            az: "us-west-2a"
            public: true
          - name: "private-1"
            cidr: "10.0.2.0/24"
            az: "us-west-2a"
            public: false
          - name: "private-2"
            cidr: "10.0.3.0/24"
            az: "us-west-2b"
            public: false
      compute:
        instances:
          - name: "web-server-1"
            type: "t3.micro"
            ami: "ami-12345678"
            key_name: "dev-key"
            security_groups:
              - "web-sg"
              - "ssh-sg"
            user_data: |
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
          - name: "app-server-1"
            type: "t3.small"
            ami: "ami-12345678"
            key_name: "dev-key"
            security_groups:
              - "app-sg"
              - "ssh-sg"
      database:
        instances:
          - name: "dev-db"
            type: "db.t3.micro"
            engine: "postgres"
            version: "13.7"
            storage: 20
            backup_retention: 7
            multi_az: false

    production:
      vpc:
        cidr: "10.1.0.0/16"
        subnets:
          - name: "public-1"
            cidr: "10.1.1.0/24"
            az: "us-west-2a"
            public: true
          - name: "public-2"
            cidr: "10.1.2.0/24"
            az: "us-west-2b"
            public: true
          - name: "private-1"
            cidr: "10.1.3.0/24"
            az: "us-west-2a"
            public: false
          - name: "private-2"
            cidr: "10.1.4.0/24"
            az: "us-west-2b"
            public: false
      compute:
        instances:
          - name: "web-server-1"
            type: "t3.medium"
            ami: "ami-12345678"
            key_name: "prod-key"
            security_groups:
              - "web-sg"
              - "ssh-sg"
            user_data: |
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
          - name: "web-server-2"
            type: "t3.medium"
            ami: "ami-12345678"
            key_name: "prod-key"
            security_groups:
              - "web-sg"
              - "ssh-sg"
          - name: "app-server-1"
            type: "t3.large"
            ami: "ami-12345678"
            key_name: "prod-key"
            security_groups:
              - "app-sg"
              - "ssh-sg"
          - name: "app-server-2"
            type: "t3.large"
            ami: "ami-12345678"
            key_name: "prod-key"
            security_groups:
              - "app-sg"
              - "ssh-sg"
      database:
        instances:
          - name: "prod-db"
            type: "db.r5.large"
            engine: "postgres"
            version: "13.7"
            storage: 100
            backup_retention: 30
            multi_az: true
```

## ⚠️ Common Mistakes

### 1. Inconsistent Indentation in Nested Structures
```yaml
# ❌ Wrong - inconsistent indentation
users:
  - name: John Doe
  email: john@example.com  # Wrong indentation
    role: admin
  - name: Jane Smith
    email: jane@example.com
    role: user

# ✅ Correct - consistent indentation
users:
  - name: John Doe
    email: john@example.com
    role: admin
  - name: Jane Smith
    email: jane@example.com
    role: user
```

### 2. Mixing List and Dictionary Syntax
```yaml
# ❌ Wrong - mixing syntax
configuration:
  - database:  # Wrong - using dash for dictionary
      host: localhost
      port: 5432
  - cache:     # Wrong - using dash for dictionary
      host: localhost
      port: 6379

# ✅ Correct - proper syntax
configuration:
  database:
    host: localhost
    port: 5432
  cache:
    host: localhost
    port: 6379
```

### 3. Overly Complex Nesting
```yaml
# ❌ Avoid excessive nesting
application:
  services:
    web:
      configuration:
        nginx:
          settings:
            server:
              blocks:
                location:
                  directives:
                    - name: "proxy_pass"
                      value: "http://backend"

# ✅ Better - flatten when possible
application:
  web:
    nginx_proxy_pass: "http://backend"
    nginx_port: 80
    nginx_ssl: true
```

## 📋 Best Practices

### 1. Use Meaningful Names
```yaml
# Good naming
application_services:
  user_management:
    endpoints:
      - path: "/users"
        method: "GET"
  order_processing:
    endpoints:
      - path: "/orders"
        method: "POST"

# Avoid generic names
services:
  service1:
    config:
      - item1
  service2:
    config:
      - item2
```

### 2. Group Related Data
```yaml
# Logical grouping
infrastructure:
  networking:
    vpc:
      cidr: "10.0.0.0/16"
      subnets:
        - name: "public"
          cidr: "10.0.1.0/24"
        - name: "private"
          cidr: "10.0.2.0/24"
  compute:
    instances:
      - name: "web-server"
        type: "t3.micro"
      - name: "app-server"
        type: "t3.small"
```

### 3. Use Comments for Complex Structures
```yaml
# Complex nested structure with comments
application:
  # Database configuration for different environments
  databases:
    development:
      host: "localhost"
      port: 5432
      name: "dev_db"
    production:
      host: "prod-db.example.com"
      port: 5432
      name: "prod_db"
  
  # Service endpoints and their configurations
  services:
    - name: "user-service"
      endpoints:
        - path: "/users"
          method: "GET"
          rate_limit: 100
        - path: "/users/{id}"
          method: "GET"
          rate_limit: 50
```

## 🔍 Working with Nested Structures

### Python Example
```python
import yaml

# Load complex nested YAML
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

# Access nested data
users = config['users']
for user in users:
    print(f"Name: {user['name']}")
    print(f"Email: {user['email']}")
    print(f"Role: {user['role']}")
    print("---")

# Access deeply nested data
company = config['company']
for dept_name, dept_data in company['departments'].items():
    print(f"Department: {dept_data['name']}")
    for employee in dept_data['employees']:
        print(f"  - {employee['name']}: {employee['position']}")
```

### JavaScript Example
```javascript
const yaml = require('js-yaml');
const fs = require('fs');

// Load YAML
const config = yaml.load(fs.readFileSync('config.yaml', 'utf8'));

// Access nested data
const users = config.users;
users.forEach(user => {
    console.log(`Name: ${user.name}`);
    console.log(`Email: ${user.email}`);
    console.log(`Role: ${user.role}`);
    console.log('---');
});

// Access deeply nested data
const company = config.company;
Object.entries(company.departments).forEach(([deptName, deptData]) => {
    console.log(`Department: ${deptData.name}`);
    deptData.employees.forEach(employee => {
        console.log(`  - ${employee.name}: ${employee.position}`);
    });
});
```

## 🎯 Key Takeaways

- **Combine lists and dictionaries** to create complex structures
- **Maintain consistent indentation** throughout nested structures
- **Use meaningful names** for keys and list items
- **Group related data** logically
- **Avoid excessive nesting** - flatten when possible
- **Use comments** to document complex structures

## 📚 Next Steps

After mastering nested structures, explore:
- [Multiline Strings](./../multiline-strings/README.md) - Handling text content
- [Comments](./../comments/README.md) - Documentation and clarity
- [Quoting Rules](./../quoting-rules/README.md) - Advanced string handling 