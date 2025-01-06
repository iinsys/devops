output "pb_sn" {
  value = aws_subnet.pb_sn.id
}

output "sg" {
  value = aws_security_group.pb_sg.id
}
