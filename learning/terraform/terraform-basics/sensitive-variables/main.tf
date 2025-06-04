variable "secret_value" {
  description = "A sensitive value"
  type        = string
  sensitive   = true
}

output "show_secret" {
  value     = var.secret_value
  sensitive = true
}
