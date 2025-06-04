resource "local_file" "foo" {
  content  = "foo"
  filename = "${path.module}/foo.txt"
}

resource "local_file" "bar" {
  content  = "bar"
  filename = "${path.module}/bar.txt"
}
