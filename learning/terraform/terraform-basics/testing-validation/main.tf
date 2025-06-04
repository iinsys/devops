resource "local_file" "test" {
  content  = "Testing and validation!"
  filename = "${path.module}/test.txt"
}
