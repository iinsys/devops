# provider "aws" {
#   region = "us-east-1"
# }

# Step 1: Use null_resource to copy S3 contents locally
resource "null_resource" "copy_s3_bucket" {
  provisioner "local-exec" {
    command = "aws s3 cp s3://xfusion-bck-10743 /opt/s3-backup/ --recursive"
  }
}

# Step 2: Remove the bucket contents and delete the bucket
resource "null_resource" "delete_s3_bucket" {
  depends_on = [null_resource.copy_s3_bucket]

  provisioner "local-exec" {
    command = <<EOT
      aws s3 rm s3://xfusion-bck-10743 --recursive && \
      aws s3api delete-bucket --bucket xfusion-bck-10743 --region us-east-1
    EOT
  }
}
