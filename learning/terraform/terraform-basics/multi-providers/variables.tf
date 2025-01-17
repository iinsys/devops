variable "filename" {
    default = "./pets.txt"
    description = "The file contains data about petes."
}
  

variable "age" {
    default = [20, 30, 40,70]
    type = list(number)
  
}

variable "fruits" {
    default = ["apple", "banana", "cherry", "orange"]
    type = list(string)
}

# variable "content" {
#   default = "My favorite pet is Mrs. Whiskers"
# }

variable "content" {
  type = map(string)
  default = {
    "statement1"       = "We love pets!"
    "statement2"       = "Pets are the best!"
    "statement3"       = "I love playing with them!"
  }
}

variable "prefix" {
    default = ["Mrs", "Mr", "Sir"]
    type = list
}

variable "seperator" {
    default = "."
}

variable "length" {
    default = "2"
}