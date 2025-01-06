terraform {
  backend "s3" {
    bucket = "nb_s3_bucket"
    key    = "state"
    region = "eu-central-1"
    dynamodb_table = "nb_s3_dynamodb_table"
  }
}
