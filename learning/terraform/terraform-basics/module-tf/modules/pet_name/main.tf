#provider "local" {}

# resource "local_file" "pet" {
#   filename = var.filename
#   content = var.content
# }

resource "local_file" "pet" {
  filename = var.filename
  content = "${var.prefix}${random_pet.my-pet.length}${var.separator}"
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.separator
  length  = var.length
}
