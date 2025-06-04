terraform {
  backend "local" {}
}

resource "local_file" "workspace_file" {
  content  = "This file is for workspace: ${terraform.workspace}"
  filename = "${path.module}/workspace-${terraform.workspace}.txt"
}
