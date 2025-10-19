# Provider is configured externally in the kodecloud environment; do not declare provider here.

# IAM policy to allow read-only access to EC2 (instances, AMIs, snapshots)
resource "aws_iam_policy" "iampolicy_siva" {
  name        = "iampolicy_siva"
  path        = "/"
  description = "Read-only access to EC2 instances, AMIs and snapshots"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "EC2ReadOnly"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags"
        ]
        Resource = "*"
      }
    ]
  })
}
