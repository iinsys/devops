# Terraform Workspaces Overview
1. **Definition**: 
   - Workspaces in Terraform allow for managing multiple environments (e.g., `dev`, `staging, prod`) within a single configuration directory.
   - Each workspace has its own state file, enabling isolation between environments.

2. **Use Cases**:
   - Managing different environments with the same configuration.
   - Avoiding the need for separate directories for each environment.

3. **Default Workspace**:
   - Terraform starts with a default workspace named `default`.

# Common Terraform Workspace Commands
1. **List Workspaces**:
   ```bash
   terraform workspace list
```
## Some other commands
```bash
# create new workspace
terraform workspace new <workspace_name>

# switch workspaces
terraform workspace select <workspace_name>

# show current workspace
terraform workspace show

# list all workspaces
terraform workspace list

# delete workspace
terraform workspace delete <workspace_name>

#destroy infrastructure
tf destroy --auto-approve
```
**Use Workspace-Specific Variables:**

You can use workspace names in variable files (e.g., `dev.tfvars`, `prod.tfvars`) or use the `terraform.workspace` built-in variable in your configurations.