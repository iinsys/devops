# Terraform Data Sources & Creation Constraints (with local provider)

This example demonstrates how to use data sources and creation constraints in Terraform, using the `local` provider for learning purposes.

## Key Concepts

- **Data Sources**: Allow you to fetch or compute data from outside Terraform or from other resources, without creating new infrastructure.
- **Creation Constraints**: Use `depends_on`, `count`, `for_each`, or conditional expressions to control when and how resources are created.

---

## Example Files
- `main.tf`: Shows how to use a data source and apply creation constraints.
- `outputs.tf`: Outputs the results for inspection.
- `README.md`: This file, with explanations and usage notes.

---

## Example: Using Data Source and Creation Constraint

- The `local_file` data source reads a file's content.
- A resource is only created if a condition is met (e.g., file content contains a specific string).

---

## Usage

1. Place a file named `example.txt` in this directory with some content.
2. Initialize the directory:
   ```sh
   terraform init
   ```
3. Run a plan to see the outputs:
   ```sh
   terraform plan
   ```
4. Apply to see the results:
   ```sh
   terraform apply
   ```

---

## Notes
- Data sources are read-only and do not create resources.
- Creation constraints help you control resource creation based on data or dependencies.
- The `local` provider is useful for learning and prototyping these concepts.

---

Happy learning!
