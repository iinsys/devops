# Terraform Modules Example (with local provider)

This example demonstrates how to use modules in Terraform, using the `local` provider for learning purposes. It includes separate environments (local, staging) to show how modules can be reused with different inputs.

## Key Concepts

- **Modules**: A module is a container for multiple resources that are used together. Modules help you organize and reuse code.
- **Calling Modules**: You can call a module multiple times with different inputs for different environments.
- **local provider**: Used here for demonstration and learning.

---

## Structure

- `modules/file_writer/`: A reusable module that writes a file with given content.
- `local-env/`: Uses the module for a local environment.
- `staging-env/`: Uses the module for a staging environment.
- `README.md`: This file, with explanations and usage notes.

---

## Usage

1. Initialize the directory:
   ```sh
   terraform init
   ```
2. Run a plan in any environment directory (e.g., `local-env`):
   ```sh
   cd local-env
   terraform plan
   ```
3. Apply to see the results:
   ```sh
   terraform apply
   ```

---

## Notes
- Modules help you avoid code duplication and enforce best practices.
- You can pass different variables to the same module for different environments.
- The `local` provider is useful for learning and prototyping module usage.

---

Happy learning!
