resource "null_resource" "local_exec_example" {
  provisioner "local-exec" {
    command = "echo 'Hello from local-exec!' > local-exec.txt"
  }
}

resource "null_resource" "remote_exec_example" {
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from remote-exec!' > /tmp/remote-exec.txt"
    ]
    connection {
      type     = "local"
      user     = "${var.local_user}"
      host     = "127.0.0.1"
    }
  }
}

variable "local_user" {
  default = "${env.USER}"
}
