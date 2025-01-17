provider "multipass" {
}

resource "multipass_machine" "devops" {
  name        = var.machine_name
  cpus        = var.cpus
  memory      = var.memory
  disk_size   = var.disk_size
  disk_format = "qcow2"
  status = var.status

##configuration for multipass provider source
terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "~> 1.4.2"
    }
  }
}

provider "multipass" {}


##life cycle

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = <<EOF
      sudo apt update
      sudo apt install -y ${join(" ", var.packages)}
      chsh -s /bin/zsh
    EOF
  }
}