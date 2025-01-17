## Types of IAC Tools

#### Configuration Management
- Ansible
- Puppet
- SaltStack

### notes
- These tools are designed to install and manage software on already existing systems or infrastructure.

- Maintain Standard Structure

- Version Control

- Idempotent
---

### Server Templating
- Docker
- Packer(HashiCorp)
- Vagrant

### Notes
- Pre Installed Software and Dependencies
- Virtual Machine or Docker images
- Immutable Infrastructure

---
### Provisioning Tools
- Terraform(HashiCorp)
- CloudFormation(AWS)
### Notes
- Deploy Immutable Infrastructure resources
- Servers, Databases, Network Components etc
- Multiple Providers

---

## Terraform
- Opensource
- Multiple Providers support
- Manages Infrastrustures, Databases, Network Components etc
- Uses hcl which is the HashiCorp Configuration Language
- Syntax is declarative: manages code from the current to the desired state

### Terraform Providers
- Physical Machines
- VMware
- AWS 
- GCP
- AZURE

These are just a few , there are more than 100 providers.

---
### Exmaple code for provisioning on aws
```h
resource "aws_instance" "webserver"{
    ami           = "ami-images-name"
    instance_type = "t2.micro"
}

resource "aws_s3_bucket" "finance"{
    bucket = "aws_s3_bucket-name"
    tags = {
        Description: "Finance and Payroll"
    }
}

resource "aws_iam_user" "admin_user"{
    name = "bansikah"
    tags = {
        Description: "Team Leader"
    }
}

```
---
- Terraform works in 3 stages
```bash
init -> plan -> apply
```
---
### A Resource
- A resource in Terraform represents a component of your infrastructure, such as a physical server, a virtual machine, a DNS record, or an S3 bucket. Resources have attributes that define their properties and behaviors, such as the size and location of a virtual machine or the domain name of a DNS record.
### A State 
- A state is the blueprint of the infrastructure deployed by terraform
---
## Terraform Installation
```bash
wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip

unzip terraform_0.13.0_linux_amd64.zip

mv terraform /usr/local/bin

terraform version

alias terraform="tf" or add in bashrc for it to persist changes
```

---
## HCL Basics
- hcl files consist of blocks and arguments
```hcl
<block> <parameters> {
    key1: value1
    key2: value2
}
```
- A block contains information about a infrastucture platform
```tf
$mkdir /root/terraform-local-file
$ cd /root/terraform-local-file
```
- create a `local.tf` file
```local.tf
resource "local_file" "pet"{
    filename = "/root/pets.txt"
    content = "We love pets!"
}
```
- Explanation:
```bash
block name -> resource
local=provider file=resource : Resource type -> local_file
Resource Name -> pet
Arguments:{filename -> /root/pets.txt
content -> "We love pets!"}
```
- Execution:
```bash
tf init-> downloads and installs plugins for our tf configuration for our providers
tf plan
tf apply
tf show: to see details of the resource that we just created.
tf destroy: to destroy all the configuration or put down the infrastructure
```
---
### Using terraform Providers
#### Official Providers
- AWS
- Google Cloud
- Azure
- Local

#### Verified Providers
- bigip
- heroku
- digitalOcean

#### Community Providers
- activedirectory
- ucloud
- netapp-gcp
---

### Configuration Directory
The Terraform Configuration Directory contains all necessary files for defining infrastructure, including .tf files for resource definitions, variable files, and modules. It also holds the .terraform/ directory (for provider plugins) and state files, if applicable.

Example Directory Structure:
```bash
my-terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── .terraform/
```
---
### Using Multiple Providers and Resources
```h
resource "local_file" "pet" {
    filename = "./pets.txt"
    content = "We Love pets!"
    file_permission = "0700"
}

resource "local_file" "cat" {
    filename = "./cats.txt"
    content = "We love cats!"
    #file_permission = "0600"
}
  
resource "random_pet" "my-pet" {
  prefix = "Mrs"
  separator = "."
  length = "1"
}
```
---
### Variables
Terraform Variables enable you to parameterize your configurations, enhancing flexibility and reusability. They allow you to define inputs that can be customized without modifying the core infrastructure code.
```h
# variables.tf
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

# main.tf
provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "ExampleInstance"
  }
}

```
### Understanding the variables block
- The variables block accepts 3 different parameters
- `default` parameter
- `type` parameter(option) and 
- `description` parameter  optional

- variable types are `string`, `number`, `boolean`, `list`, `map`, `object`, `turple` and `any`

### 1. String
A sequence of characters.
```h
variable "instance_name" {
  type    = string
  default = "my-instance"
}
```
### 2. Number
Numeric values, either integers or floats.
```h
variable "instance_count" {
  type    = number
  default = 3
}
```
### 3. Boolean
True or false values 
```h
variable "enable_logging" {
  type    = bool
  default = true
}
```
### 4. Any
Accept any data type
```h
variable "tags" {
  type    = any
  default = {
    environment = "production"
    team        = "devops"
  }
}
```
### 5. List
A sequence of values of the same type.
```h
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
```
### 6. Map
A collection of key-value pairs, where keys are strings.
```h
variable "instance_tags" {
  type = map(string)
  default = {
    Name        = "my-instance"
    Environment = "production"
  }
}
```
### 7. Object
A complex data structure with specified attributes.
```h
variable "instance_config" {
  type = object({
    instance_type = string
    ami           = string
    count         = number
  })
  default = {
    instance_type = "t2.micro"
    ami           = "ami-12345678"
    count         = 1
  }
}
```
### 8. Tuple
A sequence of values of different types.
```h
variable "server_info" {
  type    = tuple([string, number, bool])
  default = ["web-server", 2, true]
}
```

### Terraform Variable Definition Precedence
Terraform determines variable values based on a defined precedence, from highest to lowest. This hierarchy allows for flexible and dynamic configurations.

#### Precedence Order:
1. Command-Line Flags (`-var` and `-var-file`)
2. Environment Variables (`TF_VAR_ prefix`)
3. `.auto.tfvars` and `.tfvars` Files
D4. efault Values in Configuration

**Examples:**
1. Command-Line Flags:
```bash
terraform apply -var="region=us-west-2"
```
2. Environment Variables:
```bash
export TF_VAR_region="us-east-1"
terraform apply
```
3. `.auto.tfvars` File:
```bash
# terraform.auto.tfvars
region = "eu-central-1"
```
4. Default Value in `variables.tf`:
```h
variable "region" {
  type    = string
  default = "ap-southeast-1"
}
```
### Explanation:
- Command-Line Flags have the highest precedence and override all other methods.
- Environment Variables (TF_VAR_<VARIABLE_NAME>) take precedence over files and defaults.
- .auto.tfvars and .tfvars Files are automatically loaded and override default values.
- Default Values in the variable definitions are used only if no other sources provide a value.

---
###Terraform Attribute Reference Example
- Attribute references allow you to access properties of resources, modules, or data sources within your Terraform configurations.

#### Example: Referencing Resource Attributes
```h
# Define an AWS EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

# Output the instance's public IP
output "web_server_ip" {
  value = aws_instance.web_server.public_ip
}
```
### Explanation:
- **Resource Definition `(aws_instance.web_server)`:**
   - aws_instance: The resource type.
   - web_server: The resource name.
- **Attribute Reference `(aws_instance.web_server.public_ip)`:**
   -Accesses the `public_ip` attribute of the `web_server` EC2 instance.
- **Output (web_server_ip):**
Outputs the public IP address of the `web_server` instance after applying the configuration.
#### Another Example: Referencing Module Outputs
```h
# Module usage
module "vpc" {
  source = "./modules/vpc"
}

# Reference a module output
resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_id
}
```
**Explanation:**
- Module (module.vpc):
   - Uses a VPC module located at ./modules/vpc.
- Attribute Reference `(module.vpc.public_subnet_id)`:
   - Accesses the `public_subnet_id` output from the vpc module to assign the subnet to the `app_server` instance.
### Summary
  - Syntax: `<RESOURCE_TYPE>.<RESOURCE_NAME>.<ATTRIBUTE>`
  - Use Cases: Accessing resource properties, module outputs, and data source attributes.
  - Benefits: Enhances reusability and modularity by dynamically linking resources.

By using attribute references, you can create dynamic and interconnected Terraform configurations that adapt based on the properties of defined resources.

---
### Resource Dependencies
#### Implicit dependencies
- Here we don't specify which resource is actually dependent on another
-  Automatically inferred through resource references.
```h
provider "aws" {
  region = "us-west-2"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Create a Subnet that implicitly depends on the VPC
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id  # Implicit dependency on aws_vpc.main
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}
```
- Automatically inferred through resource attribute references (e.g., `aws_subnet.subnet1` depends on `aws_vpc.main` because of `vpc_id = aws_vpc.main.id`).

#### Explicit dependencies
- Here we specify which resource is actually dependent on another.
- Manually specified using depends_on to control resource creation order.
```h
# Create an S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "my-unique-bucket-name"
  acl    = "private"
}

# Create an S3 Bucket Object that explicitly depends on the S3 Bucket
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "path/to/object.txt"
  source = "local/file.txt"

  depends_on = [aws_s3_bucket.bucket]  # Explicit dependency
}
```
- Manually defined using depends_on to enforce resource creation order regardless of direct references (e.g., `aws_eip.web_eip` depends on `aws_instance.web`).
- This section combines both implicit and explicit dependencies. The EC2 instance implicitly depends on the Subnet and Security Group, while the Elastic IP explicitly depends on the EC2 instance.
#### Combined example
```h
# Create a Security Group
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id
  name   = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 Instance that implicitly depends on the Subnet and Security Group
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id  # Implicit dependency on aws_subnet.subnet1
  security_groups = [aws_security_group.sg.name]  # Implicit dependency on aws_security_group.sg

  tags = {
    Name = "WebServer"
  }
}

# Allocate an Elastic IP that explicitly depends on the EC2 Instance
resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id

  depends_on = [aws_instance.web]  # Explicit dependency to ensure instance creation first
}
```
---
### Output Variables
`Output Variables` allow you to extract and display information from your Terraform configurations after execution. They are useful for sharing data between configurations, debugging, or providing information to users.
#### Use Cases:
- Displaying resource attributes (e.g., IP addresses).
- Passing data to other Terraform workspaces or modules.
- Providing information for external scripts or integrations.

**syntax**:
```h
output "<variable_name"{
    value = "<variable_value"
    <arguments>: optional(We can have like the `description`)
}
```
**Example:**
```h
# main.tf
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

output "instance_ip" {
  description = "The public IP of the web server"
  value       = aws_instance.web.public_ip
}
```

**conmmands**:
```bash
tf output
tf apply: this will also who the output of the variable that has been created
terraform output instance_ip: to be more specific
```

---
### Purpose of State
A state is a templete of all the terraform resources that are managed by terraform in real world

# Terraform State

**Terraform State** is a crucial component that keeps track of the resources managed by Terraform. It maps your Terraform configurations to the real-world infrastructure, enabling Terraform to detect changes, manage dependencies, and plan updates accurately.

## Use Cases:
- **Tracking Resource Metadata:** Maintains information about resource IDs and attributes.
- **Change Detection:** Identifies differences between configurations and actual infrastructure.
- **Collaboration:** Enables multiple team members to work on the same infrastructure using remote state backends.
- **State Management:** Facilitates importing existing resources and managing resource dependencies.

## Practical Example:

### Initialize Terraform:
```bash
terraform init
```

### Apply Configuration:
```bash
terraform apply
```
- **Outcome:** Terraform creates resources and generates a `terraform.tfstate` file in your working directory.

### View State Contents:
```bash
terraform show
```
- **Description:** Displays the current state, showing all managed resources and their attributes.

### List Resources in State:
```bash
terraform state list
```
- **Description:** Lists all resources tracked in the state file.

### Show Specific Resource State:
```bash
terraform state show aws_instance.web
```
- **Description:** Provides detailed information about the `aws_instance.web` resource.

### Remove a Resource from State:
```bash
terraform state rm aws_instance.web
```
- **Description:** Removes the `aws_instance.web` resource from the state file without deleting the actual resource.

## Example `main.tf`:

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

## Commands Involved:

### Initialize Terraform:
```bash
terraform init
```

### Apply Configuration and Create State:
```bash
terraform apply
```

### View Entire State:
```bash
terraform show
```

### List All Resources in State:
```bash
terraform state list
```

### Show Details of a Specific Resource:
```bash
terraform state show aws_instance.web
```

### Remove a Resource from State:
```bash
terraform state rm aws_instance.web
```

### Move a Resource to a New Module or Name:
```bash
terraform state mv aws_instance.web module.web_server.aws_instance.web
```

### Import Existing Resource into State:
```bash
terraform import aws_instance.web i-1234567890abcdef0
```

## Summary:

- **State File (`terraform.tfstate`):** Stores the mapping between your Terraform configurations and actual infrastructure.
- **Local vs. Remote State:** While the state file is stored locally by default, using remote backends (e.g., AWS S3, Terraform Cloud) is recommended for team collaboration and state locking.
- **Security:** The state file can contain sensitive information. Ensure it's stored securely, especially when using remote backends.

Understanding and managing Terraform state effectively is essential for maintaining accurate and reliable infrastructure as code deployments.

---
# Terraform Commands and Descriptions

## 1. `terraform init`
Initializes the working directory containing Terraform configuration files. This command sets up the backend, downloads the necessary provider plugins, and prepares your environment for other Terraform commands.

**Usage:**
```bash
terraform init
```

---

## 2. `terraform plan`
Creates an execution plan, showing what Terraform will do when you apply the configuration. It compares the current state with the desired state defined in the configuration files.

**Usage:**
```bash
terraform plan
```

---

## 3. `terraform apply`
Executes the actions proposed in a Terraform plan to achieve the desired state. You can either run this command after `terraform plan` or directly without planning.

**Usage:**
```bash
terraform apply
```

---

## 4. `terraform destroy`
Removes all resources defined in the Terraform configuration. This is useful when you want to clean up your infrastructure.

**Usage:**
```bash
terraform destroy
```

---

## 5. `terraform show`
Displays the Terraform state or plan file. It is often used to inspect the current state of resources.

**Usage:**
```bash
terraform show
```

---

## 6. `terraform output`
Shows the values of output variables from the last Terraform apply. Useful for referencing outputs of your infrastructure.

**Usage:**
```bash
terraform output
```

---

## 7. `terraform state`
Provides commands to interact with Terraform's state file, such as listing resources, moving resources, or removing resources from the state.

**Usage:**
```bash
terraform state list
```

---

## 8. `terraform fmt`
Automatically formats Terraform configuration files to follow a consistent style and structure.

**Usage:**
```bash
terraform fmt
```

---

## 9. `terraform validate`
Checks whether the configuration is syntactically valid. It doesn't access any APIs or create resources but ensures that the Terraform code is correct.

**Usage:**
```bash
terraform validate
```

---

## 10. `terraform import`
Imports existing resources into Terraform's management. Useful when you have resources created manually or by other means that you want to bring under Terraform management.

**Usage:**
```bash
terraform import [resource_name] [resource_id]
```

---

## 11. `terraform taint`
Marks a resource for destruction and recreation during the next `terraform apply`. This is useful when you want to force the recreation of a resource.

**Usage:**
```bash
terraform taint [resource_name]
```

---

## 12. `terraform untaint`
Marks a resource that was previously tainted to prevent its destruction during the next apply.

**Usage:**
```bash
terraform untaint [resource_name]
```

---

## 13. `terraform graph`
Generates a visual graph representation of Terraform resources and their relationships. This can be useful for understanding dependencies.

**Usage:**
```bash
terraform graph
```

---

## 14. `terraform workspace`
Manages multiple workspaces, allowing you to create and switch between different environments (such as development, staging, and production) with the same configuration.

**Usage:**
```bash
terraform workspace new [workspace_name]
```

---

## 15. `terraform refresh`
Updates the Terraform state to reflect the real-world status of infrastructure without making any changes. It fetches the latest data from the cloud provider and updates the state.

**Usage:**
```bash
terraform refresh
```

---

## 16. `terraform console`
Opens an interactive console to test and evaluate expressions. Useful for debugging and experimenting with Terraform code.

**Usage:**
```bash
terraform console
```

---

## 17. `terraform providers`
Lists the providers used in your Terraform configuration. You can also view details about individual providers and versions.

**Usage:**
```bash
terraform providers
```

---

## 18. `terraform version`
Displays the installed version of Terraform.

**Usage:**
```bash
terraform version
```

---

## 19. `terraform lock`
Ensures that the dependencies used by Terraform are locked to a specific version to prevent unintended upgrades. This is important for maintaining consistent builds across environments.

**Usage:**
```bash
terraform providers lock
```
---

# Mutable vs Immutable Infrastructure in Terraform

## Mutable Infrastructure

Mutable infrastructure is infrastructure that can be changed after it has been provisioned. 
- In this approach, resources are updated, reconfigured, or patched in place without tearing them down.
- This means you can make changes without destroying the entire infrastructure, which may make it faster but introduces drift (difference between your infrastructure's state and the declared state).

### Example of Mutable Infrastructure:
- Updating a running virtual machine with a new configuration without recreating it.

## Immutable Infrastructure

Immutable infrastructure is infrastructure that is never modified after deployment. 
- Changes to the infrastructure result in the destruction of the existing environment and the deployment of new instances with the updated configuration.
- This eliminates drift and ensures consistency between the declared infrastructure and the deployed environment.

### Example of Immutable Infrastructure:
- Deploying a new virtual machine with updated configurations while destroying the old one.

### Key Differences
- **Mutable**: Changes are made in-place to the existing resources.
- **Immutable**: Changes involve creating new resources and destroying old ones.

### Use Case of Mutable Infrastructure:
- A large-scale, stateful application like databases, where you may prefer not to destroy resources when making changes.

### Use Case of Immutable Infrastructure:
- For stateless applications or microservices, immutable infrastructure ensures reliable deployment and reduces configuration drift.

---
# Terraform Lifecycle Rules
Lifecycle rules in Terraform provide fine-grained control over the behavior of resources during their creation, modification, and deletion. They are particularly useful for managing stateful resources where you need to perform specific actions before or after resource operations.

#### Common Lifecycle Rules
- `ignore_changes:` Prevents Terraform from managing a specific attribute of a resource. This is useful for attributes that are managed externally or should remain unchanged.
```h
resource "aws_s3_bucket" "example" {
  bucket = "my-bucket"

  lifecycle {
    ignore_changes = [
      "tags",
    ]
  }
}
```

- `prevent_destroy:` Prevents Terraform from destroying a resource. This is useful for resources that are critical to your infrastructure or require manual cleanup.
```h
resource "aws_instance" "example" {
  # ...

  lifecycle {
    prevent_destroy = true
  }
}
```
- `create_before_destroy:` Ensures that a new resource is created before the old one is destroyed. This is useful for resources that require a seamless transition.
```h
resource "aws_instance" "example" {
  # ...

  lifecycle {
    create_before_destroy = true
  }
}
```
- `provisioner:` Allows you to execute arbitrary commands or scripts during the resource's lifecycle. This can be used for tasks like setting up configurations, installing software, or running custom scripts.
```h
resource "aws_instance" "example" {
  # ...

  lifecycle {
    provisioner "local-exec" {
      command = "echo 'Provisioning instance'"
    }
  }
}
```
#### Additional Considerations
- Nested blocks: You can nest lifecycle rules within resource blocks for more granular control.
- Multiple rules: You can apply multiple lifecycle rules to a single resource.
- Conditional logic: You can use conditional logic to apply lifecycle rules based on specific conditions.
---

## Terraform Data Sources

**Data sources** in Terraform provide a way to retrieve information about existing resources from your infrastructure. This is useful for scenarios where you need to reference existing resources in your configuration or for dynamic configuration based on existing infrastructure.

### Common Data Sources

* **`aws_s3_bucket`:** Retrieves information about an existing S3 bucket.
```terraform
data "aws_s3_bucket" "example" {
  bucket = "my-bucket"
}
```

- `google_compute_instance:` Retrieves information about an existing Compute Engine instance.
```h
data "google_compute_instance" "example" {
  name = "my-instance"
}
```
- `azurerm_resource_group:` Retrieves information about an existing Azure resource group.
```h
data "azurerm_resource_group" "example" {
  name = "my-resource-group"
}
```
- `local_file:` Retrieves the contents of a local file.
```h
data "local_file" "example" {
  filename = "my-file.txt"
}
```
- `external:` Retrieves data from an external source using a custom script or API.
```h
data "external" "example" {
  program = "./my-script.sh"
}
```
### Using Data Sources
- Define the data source: Specify the type of data source and its configuration.
- Reference the data source: Use the data source's attributes within other resources or outputs.

**Example: Using aws_s3_bucket**
```h
data "aws_s3_bucket" "example" {
  bucket = "my-bucket"
}

resource "aws_s3_object" "example" {
  bucket = data.aws_s3_bucket.example.id
  key    = "my-object.txt"
  content = "Hello, world!"
}
```
### Additional Considerations
- Nested data sources: You can nest data sources within other resources for more complex scenarios.
- Conditional logic: Use conditional logic to apply data sources based on specific conditions.
- Dynamic configuration: Use data sources to dynamically configure resources based on existing infrastructure.
---

## Terraform Meta Arguments

**Meta arguments** in Terraform provide additional configuration options for resources, allowing you to customize their behavior and interaction with other components. These arguments are typically optional and are used to control aspects like dependencies, lifecycle, and provisioning.

### Common Meta Arguments

* **`depends_on`:** Specifies a dependency between resources. This ensures that one resource is created or updated before another.
```terraform
resource "aws_instance" "example" {
  # ...

  depends_on = [
    aws_security_group.example
  ]
}
```
- `lifecycle:` Controls the behavior of a resource during its lifecycle, such as preventing destruction or executing custom scripts.
```h
resource "aws_instance" "example" {
  # ...

  lifecycle {
    ignore_changes = [
      "tags",
    ]
    provisioner "local-exec" {
      command = "echo 'Provisioning instance'"
    }
  }
}
```
- `for_each:` Creates multiple instances of a resource based on a list or map.
```h
resource "aws_instance" "example" {
  for_each = {
    web = {
      instance_type = "t2.micro"
    }
    db = {
      instance_type = "db.t2.micro"
    }
  }

  instance_type = each.value.instance_type
}
```
- `count:` Creates multiple instances of a resource based on a number.
```h
resource "aws_instance" "example" {
  count = 2

  instance_type = "t2.micro"
}
```
- `provider:` Specifies a different provider for a resource if multiple providers are configured.
```h
resource "aws_s3_bucket" "example" {
  provider = "aws.us-east-1"

  bucket = "my-bucket"
}
```
### Using Meta Arguments
- Identify the desired behavior: Determine which meta argument is appropriate for your use case.
- Set the meta argument: Add the meta argument to the resource block and configure its settings.
- Consider dependencies and interactions: Ensure that meta arguments are used correctly to avoid conflicts or unexpected behavior.

**Example: Using depends_on and lifecycle**
```h
resource "aws_security_group" "example" {
  # ...
}

resource "aws_instance" "example" {
  # ...

  depends_on = [
    aws_security_group.example
  ]

  lifecycle {
    provisioner "local-exec" {
      command = "echo 'Provisioning instance'"
    }
  }
}
```
This configuration ensures that the instance is created after the security group and executes a provisioning script.

---
## Terraform Version Constraints

Version constraints in Terraform specify the desired version range for providers or modules. This ensures compatibility and prevents unexpected behavior.

**Example:**

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
```