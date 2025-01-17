variable "filename" {
  type = string
  default = "pet_name.txt"
}

variable "content" {
  default = "I love pets! they are very awesosme" 
}

variable "prefix" {
  type = string
  default = "My favorite pet is "
}

variable "separator" {
  type = string
  default = "-"
}

variable "length" {
  type = number
  default = 8
}