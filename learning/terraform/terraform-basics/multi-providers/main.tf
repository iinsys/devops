resource "local_file" "pet" {
    filename = var.filename
    content = var.content["statement2"]
}

resource "random_pet" "my_pet" {
    prefix = var.prefix
    separator = var.seperator
    length  = var.length
}
  
