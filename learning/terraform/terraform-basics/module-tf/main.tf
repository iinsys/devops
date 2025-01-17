provider "local" {
  
}
module "pet_name" {
  source = "./modules/pet_name"

  filename = "./pets.txt"
  prefix = "My favorite pet is "
  separator = " - "
  length = 8
}

output "pet_name_file" {
    value = module.pet_name.pet_file_name
}
