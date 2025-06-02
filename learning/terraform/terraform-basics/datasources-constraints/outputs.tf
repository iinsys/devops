output "original_content" {
  value = data.local_file.example.content
  description = "Content of the original example.txt file."
}

output "copy_created" {
  value = local_file.copy.*.filename
  description = "Filename of the copy if created (empty if not)."
}
