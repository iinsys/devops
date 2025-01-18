# spacelift-demo
Want to learn more about Spacelift Visit [Documentation](https://docs.spacelift.io/) also checkout this [video tutorial](https://www.youtube.com/watch?v=gfxw_zPpO-4)

## Domy policy
```plaintext
package spacelift

deny["Policy was denied"]{
    true
}
```

## Plan policy to restrict creation of instance larger than t2.micro
```plaintext
package spacelift

deny["Policy was denied"] {
    instance := input.terraform.resource_changes[_].change.after.instance_type
    instance != "t2.micro"
}

sample { true }
```

## destroy infrastructure
```bash
terraform destroy -auto-approve
```