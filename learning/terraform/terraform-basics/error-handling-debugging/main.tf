resource "local_file" "error_demo" {
  content  = "This will error if filename is empty."
  filename = var.filename
}

variable "filename" {
  description = "Filename for the local_file resource. Leave empty to see an error."
  type        = string
  default     = ""
}
