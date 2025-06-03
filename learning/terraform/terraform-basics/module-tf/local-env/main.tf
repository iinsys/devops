module "file_writer" {
  source   = "../modules/file_writer"
  filename = "local.txt"
  content  = "This is the local environment file."
}

output "local_file_content" {
  value = module.file_writer.file_content
}
