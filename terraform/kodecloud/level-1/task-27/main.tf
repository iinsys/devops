# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_anita"

  tags = {
    Name = "iamuser_anita"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_anita"
  description = "IAM policy allowing EC2 read actions for anita"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}

# Attach policy to IAM user
resource "aws_iam_user_policy_attachment" "anita_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}
