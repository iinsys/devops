# Example: Data Source and Creation Constraint

data "local_file" "example" {
  filename = "example.txt"
}

resource "local_file" "copy" {
  count    = can(regex("create", data.local_file.example.content)) ? 1 : 0
  filename = "copy.txt"
  content  = data.local_file.example.content
  file_permission = "0644"
}
