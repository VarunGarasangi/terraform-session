provider "aws" {
  region = "ap-south-1"


}
terraform {
  backend "s3" {
    bucket = "s3bucket-varun1"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-locks"
    
    
  }
}