terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "local_file" "example" {
  content  = "Hello, Terraform state!"
  filename = "${path.module}/hello.txt"
}
