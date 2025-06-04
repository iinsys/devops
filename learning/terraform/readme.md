# Terraform Learning Path

This guide will help you learn Terraform from beginner to experienced level using practical, local, and cloud-based examples in this repository. Each topic is organized in a recommended order, with hands-on folders and step-by-step READMEs.

## Beginner Level
1. **Terraform Basics** ([terraform-basics/](./terraform-basics/))
   - Start here to learn the core concepts and commands.
   - Topics include:
     - Providers & Resources
     - Input & Output Variables
     - Data Sources
     - Local File Resources
     - State Management ([state-management/](./terraform-basics/state-management/))
     - Workspaces ([workspaces/](./terraform-basics/workspaces/))
     - Testing & Validation ([testing-validation/](./terraform-basics/testing-validation/))
     - Error Handling & Debugging ([error-handling-debugging/](./terraform-basics/error-handling-debugging/))

2. **Provisioners** ([provisioners/](./terraform-basics/provisioners/))
   - Learn how to run local and remote commands during resource creation.

3. **Resource Targeting** ([resource-targeting/](./terraform-basics/resource-targeting/))
   - Practice applying or destroying specific resources and understanding dependencies.

4. **Importing Resources** ([importing/](./terraform-basics/importing/))
   - Bring existing resources under Terraform management.

5. **Sensitive Variables** ([sensitive-variables/](./terraform-basics/sensitive-variables/))
   - Learn to protect secrets in your code and outputs.

6. **Local Resources** ([local-resources/](./terraform-basics/local-resources/))
   - Practice with local_file, local_sensitive_file, and data sources.

## Intermediate Level
7. **Modules** ([module-tf/](./terraform-basics/module-tf/))
   - Organize and reuse your Terraform code.

8. **Meta-Arguments** ([meta-arguments/](./terraform-basics/meta-arguments/))
   - Use `count`, `for_each`, and `depends_on` for advanced resource management.

9. **Iteration** ([iteration-tf/](./terraform-basics/iteration-tf/))
   - Create multiple resources dynamically.

10. **Data Sources** ([data-sources/](./terraform-basics/data-sources/))
    - Fetch and use data from other resources or external sources.

11. **Life Cycle Rules** ([life-cycle-rules/](./terraform-basics/life-cycle-rules/))
    - Control resource creation, update, and deletion behavior.

## Advanced Level
12. **Managing Secrets** ([../advanced-terraform/managing-secrets/](../advanced-terraform/managing-secrets/))
    - Securely manage secrets and sensitive data.

13. **Multi-Provider & Multi-Cloud** ([multi-providers/](./terraform-basics/multi-providers/))
    - Use multiple providers in a single configuration.

14. **Cloud Provider Examples**
    - **AWS** ([../aws/](../aws/))
    - **GCP** ([../Cloud%20(GCP)/](../Cloud%20(GCP)/))
    - **Azure** ([../azure/](../azure/))
    - Practice with real cloud resources, IAM, networking, and more.

15. **Remote State & Collaboration**
    - Learn about remote backends (S3, Azure Blob, etc.) and state locking (see cloud provider folders).

## How to Use This Repository
- Each topic folder contains a `main.tf` and a `readme.md` with explanations and hands-on steps.
- Start from the top and work your way down for a comprehensive learning experience.
- Use `terraform init`, `plan`, `apply`, and `destroy` as you follow along.
- Clean up resources after each test to avoid clutter.

## Tips for Success
- Read the notes in each README for best practices and real-world advice.
- Experiment with the code—try changing variables and see what happens.
- Use version control (git) to track your progress and changes.
- For production, always use remote state and secret managers.

Happy learning and building with Terraform!