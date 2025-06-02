# Terraform Iteration with the local Provider

This example demonstrates how to use iteration in Terraform using the three main methods: `for`, `for_each`, and `count`.

## Key Concepts

- **for**: Used in expressions to transform or filter lists and maps. Great for creating new lists/maps from existing ones.
- **for_each**: Used to create multiple resources from a set or map. Each resource gets a unique key from the set/map.
- **count**: Used to create a specific number of resource instances, indexed by `count.index`.

## Example Files

- `local.tf`: Shows how to use `for_each` and `for` with local values.
- `outputs.tf`: Demonstrates how to output iterated values.
- `variables.tf`: (Optional) For variable definitions if needed.

---

## Example: Iterating with local values

Suppose you want to create a list of server names and transform them to uppercase.

### local.tf
```hcl
locals {
  server_names = ["web1", "web2", "web3"]
  upper_server_names = [for name in local.server_names : upper(name)]
  server_map = { for idx, name in local.server_names : name => idx }
}
```

### outputs.tf
```hcl
output "upper_server_names" {
  value = local.upper_server_names
}

output "server_map" {
  value = local.server_map
}
```

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
- You can experiment by changing the `server_names` list or the transformation logic.
- The `local` provider is great for learning and prototyping iteration logic in Terraform.
- Use `for` for transforming data.
- Use `for_each` when you want to create resources for each unique key in a set or map.
- Use `count` when you want to create a fixed number of resources, indexed numerically.
- Only one of `for_each` or `count` can be used on a resource at a time.

---

Happy learning!
