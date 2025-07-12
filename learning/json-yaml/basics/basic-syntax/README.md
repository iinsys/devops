# YAML Basic Syntax

YAML (YAML Ain't Markup Language) is a human-readable data serialization format. Understanding basic syntax is the foundation for working with YAML files.

## 🏗️ Structure Fundamentals

### Indentation Rules
- **Use 2 spaces** for indentation (never tabs)
- **Consistent indentation** is crucial for YAML parsing
- **Hierarchy** is defined by indentation level

### Document Structure
```yaml
# This is a YAML document
# Each YAML file can contain multiple documents separated by ---
---
# Document 1
key: value
---
# Document 2
another_key: another_value
```

## 📝 Basic Elements

### 1. Key-Value Pairs
```yaml
# Simple key-value pair
name: John Doe
age: 30
is_active: true
```

### 2. Comments
```yaml
# This is a comment
name: John Doe  # Inline comment
# Comments start with #
```

### 3. Indentation Examples
```yaml
# Correct indentation (2 spaces)
person:
  name: John Doe
  age: 30
  address:
    street: 123 Main St
    city: New York
    zip: 10001

# Wrong indentation (will cause errors)
person:
name: John Doe  # Wrong - no indentation
  age: 30       # Wrong - inconsistent indentation
```

## 🔧 Real-World Examples

### Kubernetes Pod Configuration
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
    environment: production
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
```

### Docker Compose Service
```yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    environment:
      - NGINX_HOST=localhost
      - NGINX_PORT=80
    volumes:
      - ./html:/usr/share/nginx/html
```

### Ansible Playbook
```yaml
---
- name: Install and configure web server
  hosts: webservers
  become: yes
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
    - name: Start nginx service
      service:
        name: nginx
        state: started
        enabled: yes
```

## ⚠️ Common Mistakes

### 1. Using Tabs Instead of Spaces
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

### 2. Inconsistent Indentation
```yaml
# ❌ Wrong - mixed indentation
person:
  name: John Doe
    age: 30  # Wrong indentation level

# ✅ Correct - consistent indentation
person:
  name: John Doe
  age: 30
```

### 3. Missing Spaces After Colon
```yaml
# ❌ Wrong - no space after colon
name:John Doe
age:30

# ✅ Correct - space after colon
name: John Doe
age: 30
```

## 🧪 Practice Examples

### Example 1: Simple Configuration
```yaml
# config.yaml
database:
  host: localhost
  port: 5432
  name: myapp
  user: admin
  password: secret123
```

### Example 2: Application Settings
```yaml
# settings.yaml
app:
  name: My Application
  version: 1.0.0
  debug: false
  features:
    - authentication
    - logging
    - monitoring
  limits:
    max_users: 1000
    timeout: 30
```

### Example 3: Environment Configuration
```yaml
# environment.yaml
development:
  database_url: postgresql://localhost/dev
  log_level: debug
  cache_enabled: false

production:
  database_url: postgresql://prod-server/prod
  log_level: info
  cache_enabled: true
```

## 📋 Best Practices

1. **Always use 2 spaces** for indentation
2. **Be consistent** with indentation throughout the file
3. **Use comments** to explain complex configurations
4. **Validate your YAML** before using it in production
5. **Use meaningful key names** that are descriptive
6. **Group related data** logically

## 🔍 Validation Tools

### Command Line Validation
```bash
# Using Python's yaml module
python -c "import yaml; yaml.safe_load(open('file.yaml'))"

# Using yamllint
yamllint file.yaml

# Using yq for querying
yq eval '.' file.yaml

# Or use the online YAML Linter
# Visit: https://yaml-linter.vercel.app/
```

### Online Validators
- [YAML Linter](https://yaml-linter.vercel.app/) - Custom YAML validator and formatter
- [YAML Validator](http://www.yamllint.com/)

## 🎯 Key Takeaways

- **Indentation is critical** - YAML uses indentation to define structure
- **2 spaces only** - Never use tabs
- **Consistency matters** - Maintain uniform indentation
- **Comments help** - Use `#` for documentation
- **Validate often** - Check syntax before deployment

## 📚 Next Steps

After mastering basic syntax, explore:
- [Scalars](./../scalars/README.md) - Understanding data types
- [Lists](./../lists/README.md) - Working with sequences
- [Dictionaries](./../dictionaries/README.md) - Key-value structures 