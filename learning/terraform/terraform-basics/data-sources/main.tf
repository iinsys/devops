resource "local_file" "pet" {
  filename = "${path.module}/pets.txt"
  content = data.local_file.dog.content
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix
  separator = var.seperator
  length    = var.length
}

# data "local_file" "dog" {
#   filename = "./dogs.txt"
# }