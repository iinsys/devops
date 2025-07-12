# YAML Scalars

Scalars are the basic data types in YAML. They represent single values and are the building blocks for more complex data structures.

## 📊 Scalar Types

### 1. Strings
Strings are the most common scalar type in YAML.

```yaml
# Simple strings
name: John Doe
email: john@example.com
description: This is a simple string

# Strings with special characters
path: /usr/local/bin
url: https://example.com/api/v1
regex: ^[a-zA-Z0-9]+$
```

### 2. Numbers

#### Integers
```yaml
# Positive integers
age: 30
port: 8080
year: 2024
count: 1000

# Negative integers
temperature: -5
offset: -100
```

#### Floats
```yaml
# Decimal numbers
price: 19.99
pi: 3.14159
temperature: 98.6
percentage: 85.5
```

#### Scientific Notation
```yaml
# Scientific notation
avogadro: 6.022e23
small_number: 1.602e-19
```

### 3. Booleans
```yaml
# Boolean values
is_active: true
is_deleted: false
enabled: true
disabled: false

# Common boolean variations
debug: yes    # true
production: no # false
on: on        # true
off: off      # false
```

### 4. Null Values
```yaml
# Null/None values
middle_name: null
optional_field: ~
empty_value: null
```

## 🔧 Real-World Examples

### Application Configuration
```yaml
# app-config.yaml
application:
  name: "My Web App"
  version: "2.1.0"
  debug: false
  port: 3000
  timeout: 30.5
  max_connections: 100
  database_url: null  # Will be set by environment
  features:
    authentication: true
    logging: true
    monitoring: false
```

### Database Configuration
```yaml
# database.yaml
database:
  host: "localhost"
  port: 5432
  name: "myapp_production"
  user: "db_user"
  password: "secret123"
  ssl: true
  connection_timeout: 10.5
  max_pool_size: 20
  retry_attempts: 3
```

### Environment Variables
```yaml
# env.yaml
environment:
  NODE_ENV: "production"
  PORT: 8080
  DEBUG: false
  LOG_LEVEL: "info"
  API_TIMEOUT: 30.0
  CACHE_TTL: 3600
  ENABLE_METRICS: true
  DATABASE_URL: null  # Set via environment
```

## ⚠️ Common Pitfalls

### 1. String vs Number Confusion
```yaml
# ❌ Ambiguous - could be string or number
version: 2.1.0

# ✅ Clear - explicitly string
version: "2.1.0"

# ✅ Clear - explicitly number
version_number: 2.1
```

### 2. Boolean Ambiguity
```yaml
# ❌ Ambiguous boolean values
enabled: yes
disabled: no

# ✅ Clear boolean values
enabled: true
disabled: false
```

### 3. Null vs Empty String
```yaml
# ❌ Confusing - null vs empty string
optional_field: ""
required_field: null

# ✅ Clear distinction
optional_field: null      # No value provided
default_value: ""         # Empty string intentionally
```

## 🧪 Advanced Examples

### API Configuration
```yaml
# api-config.yaml
api:
  base_url: "https://api.example.com"
  version: "v1"
  timeout: 30.0
  retry_attempts: 3
  rate_limit: 1000
  enable_caching: true
  cache_ttl: 300.5
  authentication:
    enabled: true
    token_expiry: 3600
    refresh_threshold: 300.0
```

### Monitoring Configuration
```yaml
# monitoring.yaml
monitoring:
  enabled: true
  interval: 60.0
  alert_threshold: 90.5
  retention_days: 30
  metrics:
    cpu_usage: true
    memory_usage: true
    disk_usage: true
    network_io: false
  alerts:
    email_enabled: true
    slack_enabled: false
    webhook_url: null
```

### Feature Flags
```yaml
# features.yaml
features:
  new_ui: true
  beta_features: false
  experimental_api: true
  legacy_support: false
  performance_optimization: true
  debug_mode: false
  maintenance_mode: false
```

## 📋 Best Practices

### 1. Use Quotes When Needed
```yaml
# Use quotes for strings that might be confused with other types
version: "2.1.0"        # String version
port: 8080              # Number
path: "/usr/local/bin"  # String with special chars
```

### 2. Be Explicit with Booleans
```yaml
# Use true/false instead of yes/no
enabled: true
disabled: false
```

### 3. Handle Null Values Properly
```yaml
# Use null for missing optional values
optional_field: null
required_field: "value"
```

### 4. Use Descriptive Names
```yaml
# Good naming
max_retry_attempts: 3
connection_timeout_seconds: 30.0
enable_debug_logging: true

# Avoid ambiguous names
retries: 3
timeout: 30.0
debug: true
```

## 🔍 Type Validation

### Python Example
```python
import yaml

# Load and validate YAML
with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)
    
# Check types
print(f"Name: {type(config['name'])}")           # <class 'str'>
print(f"Age: {type(config['age'])}")             # <class 'int'>
print(f"Price: {type(config['price'])}")         # <class 'float'>
print(f"Active: {type(config['active'])}")       # <class 'bool'>
print(f"Optional: {type(config['optional'])}")   # <class 'NoneType'>
```

### JavaScript Example
```javascript
const yaml = require('js-yaml');
const fs = require('fs');

// Load YAML
const config = yaml.load(fs.readFileSync('config.yaml', 'utf8'));

// Check types
console.log(`Name: ${typeof config.name}`);           // string
console.log(`Age: ${typeof config.age}`);             // number
console.log(`Price: ${typeof config.price}`);         // number
console.log(`Active: ${typeof config.active}`);       // boolean
console.log(`Optional: ${config.optional === null}`); // true
```

## 🎯 Key Takeaways

- **Strings** are the most common scalar type
- **Numbers** can be integers or floats
- **Booleans** should use `true`/`false` for clarity
- **Null** represents missing or undefined values
- **Use quotes** when there's ambiguity
- **Be consistent** with your data types

## 📚 Next Steps

After understanding scalars, explore:
- [Lists](./../lists/README.md) - Working with sequences
- [Dictionaries](./../dictionaries/README.md) - Key-value structures
- [Nested Structures](./../nested-structures/README.md) - Combining scalars in complex ways 