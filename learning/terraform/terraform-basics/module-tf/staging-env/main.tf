module "file_writer" {
  source   = "../modules/file_writer"
  filename = "staging.txt"
  content  = "This is the staging environment file."
}

output "staging_file_content" {
  value = module.file_writer.file_content
}
