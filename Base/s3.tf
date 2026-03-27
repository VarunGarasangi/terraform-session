resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-varun-bucket-terraform-1999999"


  tags = {
    Name        = "Demo1 S3 Bucket"
    Environment = "Dev"
  }
  
}