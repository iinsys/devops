resource "local_file" "imported" {
  content  = "This file was imported into Terraform!"
  filename = "${path.module}/imported.txt"
}
