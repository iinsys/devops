resource "local_file" "pet" {
    filename = "./pets.txt"
    content = "We Love pets!"
    file_permission = "0700"
}

resource "local_file" "cat" {
    filename = "./cats.txt"
    content = "We love cats!"
    #file_permission = "0600"
}
  
resource "random_pet" "my-pet" {
  prefix = "Mrs"
  separator = "."
  length = "1"
}