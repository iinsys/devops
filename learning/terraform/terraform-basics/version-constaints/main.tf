terraform {
  required_providers {
    local = {
        source = "hashicorp/local"
        version = "1.4.0"
        #version = "!= 2.0.0" # specify that i don't want this version
        #version = " > 2.0.0" choose a version greater than 2.0.0
        #version = "> 2.0.0, != 2.0.0" choose a version
        # version = "~> 2.0.0" specific version
    }
  }
}

resource "local_file" "pets" {
    content = "I love pets!"
    filename = "${path.module}/pets.txt"
}