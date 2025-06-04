resource "local_file" "basic" {
  content  = "This is a basic local file."
  filename = "${path.module}/basic.txt"
}

resource "local_sensitive_file" "secret" {
  content  = "super_secret_password"
  filename = "${path.module}/secret.txt"
}

data "local_file" "read_basic" {
  filename = local_file.basic.filename
}
