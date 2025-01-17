variable "machine_name" {
  default = "devops-machine"
}

variable "cpus" {
  default = 2
}

variable "memory" {
  default = 4096
}

variable "disk_size" {
  default = 20
}

variable "status" {
  type        = string
  default     = "running"
  description = "Desired status for the Multipass machine (running, stopped, paused)"
}

# variable "multipass_version" {
#     #type = string
#     default = "~> 1.0.0"
  
# }

variable "packages" {
  type = list(string)
  default = [
    "nginx",
    "zsh",
    "git",
  ]
}