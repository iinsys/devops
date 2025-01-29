# variable "mysql_username" {
#   description = "MySQL username"
#   type        = string
#   sensitive = true
# }

# variable "mysql_password" {
#   description = "MySQL password"
#   type        = string
#   sensitive = true
# }

variable "vault_token" {
  description = "Vault token"
  type = string
  sensitive = true
}
