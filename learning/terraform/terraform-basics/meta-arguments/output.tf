output "pets" {
    value = local_file.pet
    sensitive = true
}