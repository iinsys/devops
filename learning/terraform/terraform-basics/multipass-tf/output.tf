output "machine_ip" {
  value = multipass_machine.devops-machine.ip_address
  description = "IP address of the DevOps machine"
}

output "machine_name" {
  value       = multipass_machine.devops-machine.name
  description = "Name of the DevOps machine"
}

output "machine_status" {
  value       = multipass_machine.devops-machine.state
  description = "Current state of the DevOps machine"
}

output "cpus" {
    value = multipass_machine.devops-machine.cpus
    description = "Number of CPU cores"
}
  