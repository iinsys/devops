# resource "local_file" "pet" {
#   filename = each.value
#   for_each = var.filename
# }

resource "local_file" "pet" {
  for_each = toset(var.filename)

  filename        = each.value
  content         = "This is the content for ${each.value}"
  file_permission = "0700"
}
