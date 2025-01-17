# variable "filename" {
#     type = set(string)
#     default = [
#          "./pets.txt", 
#          "./dogs.txt",
#          "./cats.txt"]
# }

variable "filename" {
  type = list(string)
  default = [
    "./pets.txt", 
    "./dogs.txt",
    "./cats.txt"
  ]
}
