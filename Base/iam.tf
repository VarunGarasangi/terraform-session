locals {
  policy_list = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    aws_iam_policy.ec2_s3_policy.arn
  ]
}

# -----------------------------
# Custom S3 Policy
# -----------------------------
resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "ec2-s3-access-policy"
  description = "Allow EC2 to access specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # EC2 Describe (optional but useful)
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*"
        ]
        Resource = "*"
      },

      # S3 Object Level Access
      {
        Sid    = "S3ObjectAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::demo-bucket-terraform-43fc539b/*"
      },

      # S3 Bucket Level Access
      {
        Sid    = "S3BucketAccess"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = "arn:aws:s3:::demo-bucket-terraform-43fc539b"
      }
    ]
  })
}

# -----------------------------
# IAM Role for EC2
# -----------------------------
resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# -----------------------------
# Attach Policies to Role
# -----------------------------
resource "aws_iam_role_policy_attachment" "ec2_attachment_policy" {
  count      = length(local.policy_list)
  role       = aws_iam_role.ec2_role.name
  policy_arn = local.policy_list[count.index]
}

# -----------------------------
# Instance Profile
# -----------------------------
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-access-profile"
  role = aws_iam_role.ec2_role.name
}