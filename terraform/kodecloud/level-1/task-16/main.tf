# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_iam_policy" "ec2_readonly" {
  name        = "iampolicy_rose"
  description = "IAM policy to allow read-only access to the EC2 console"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:GetConsoleOutput",
          "ec2:GetPasswordData"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}
