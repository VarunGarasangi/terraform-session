locals {
  policy_list = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    aws_iam_policy.ec2_s3_policy.arn
  ]


}
resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "ec2-s3-access-policy"
  description = "this policy allows EC2 instances to access S3 buckets for reading and writing data"
   

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid    = "S3ReadWriteAccess"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketVersions",
          "s3:ListBucketMultipartUploads",
          
        ]

        Resource = "*"
      },
    ]
  })

}

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
resource "aws_iam_role_policy_attachment" "ec2_attachment_policy" {
  count      = length(local.policy_list)
  role       = aws_iam_role.ec2_role.name
  policy_arn = local.policy_list[count.index]


}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-access-profile"
  role = aws_iam_role.ec2_role.name

}