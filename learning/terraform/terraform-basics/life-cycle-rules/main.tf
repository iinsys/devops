resource "local_file" "pet" {
  filename = var.filename
  content  = "My favorite pet is ${random_pet.my-pet.id}"
  file_permission = "0777"
  #Life cycle rules
  lifecycle {
    create_before_destroy = true
  }
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix
  separator = var.seperator
  length    = var.length
}

##output block
output content {
    value       = local_file.pet.content
    sensitive = false
    description = "Content of the pet file"
  
}
output "pet-name" {
  value       = random_pet.my-pet.id
  description = "Record the value of pet ID generated by the random_pet resource"
}