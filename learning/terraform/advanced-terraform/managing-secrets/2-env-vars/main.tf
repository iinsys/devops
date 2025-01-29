resource "local_file" "credentials_file" {
  filename = "${path.module}/mysql_credentials.txt"
  content = <<EOT
    MySQL Username: ${var.mysql_username}
    MySQL Password: ${var.mysql_password}
  EOT
}