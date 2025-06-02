variable "filename" {
  description = "Name of the file to write."
  type        = string
}

variable "content" {
  description = "Content to write to the file."
  type        = string
}

resource "local_file" "example" {
  filename = var.filename
  content  = var.content
  file_permission = "0644"
}

output "file_content" {
  value = local_file.example.content
  description = "Content written to the file."
}
