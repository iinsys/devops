## set vault provider
provider "vault" {
  address = "http://localhost:8200"
  token = var.vault_token
}

data "vault_generic_secret" "database" {
  path = "secret/myapp/database"
}

resource "local_file" "credentials_file" {
  filename = "${path.module}/mysql_credentials.txt"
  content = <<EOT
    MySQL Username: ${data.vault_generic_secret.database.data["mysql_username"]}
    MySQL Password: ${data.vault_generic_secret.database.data["mysql_password"]}
  EOT
}