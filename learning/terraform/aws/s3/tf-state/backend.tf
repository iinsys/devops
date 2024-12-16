## Backend configuration

terraform {
  backend "s3" {
    bucket         = "nb-bucket22"
    key            = "terraform.tfstate"
    region         =  "eu-central-1"  
    dynamodb_table = "nb-lock-table" 
  }
}