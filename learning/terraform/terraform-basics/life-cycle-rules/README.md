# Terraform Resource Lifecycle Rules (with local provider)

This example demonstrates how to use resource lifecycle rules in Terraform, using the `local` provider for learning purposes.

## Key Concepts

- **lifecycle block**: Controls how Terraform handles resource creation, update, and deletion.
  - `create_before_destroy`: Ensures a new resource is created before the old one is destroyed (useful for resources where downtime is not acceptable).
  - `prevent_destroy`: Prevents accidental deletion of a resource.
  - `ignore_changes`: Ignores changes to specific arguments, so Terraform does not update the resource if those arguments change.

---

## Example Files
- `main.tf`: Shows how to use lifecycle rules with a local file resource.
- `outputs.tf`: Outputs the results for inspection.
- `README.md`: This file, with explanations and usage notes.

---

## Example: Using Lifecycle Rules

- The `local_file` resource demonstrates all three lifecycle rules (comment/uncomment to experiment).

---

## Usage

1. Initialize the directory:
   ```sh
   terraform init
   ```
2. Run a plan to see the outputs:
   ```sh
   terraform plan
   ```
3. Apply to see the results:
   ```sh
   terraform apply
   ```

---

## Notes
- Use `create_before_destroy` to avoid downtime.
- Use `prevent_destroy` to protect critical resources.
- Use `ignore_changes` to avoid unnecessary updates.
- Only use these rules when you understand their impact on your infrastructure.

---

Happy learning!
