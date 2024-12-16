resource "aws_dynamodb_table" "nb_lock_table" {
  name           = "nb-lock-table"  
  hash_key       = "LOCKID"     

  # Define only the hash key attribute, no range key or additional attributes
  attribute {
    name = "LOCKID"
    type = "S"  
  }

  # Default read and write capacity units
  billing_mode = "PAY_PER_REQUEST"  # Default billing mode is PROVISIONED, but you can change to PAY_PER_REQUEST if needed
  read_capacity  = 5
  write_capacity = 5

  tags = {
    Name = "nb-lock-table"
  }
}


