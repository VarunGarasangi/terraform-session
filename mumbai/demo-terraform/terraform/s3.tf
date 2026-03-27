resource "aws_s3_bucket" "demo-bucket" {
  count  = var.count_s3
  bucket = "demo-varun-bucket-terraform-1999999"


  tags = merge(var.common_tags,
    {
      Name = "Demo S3 Bucket"

  })

}