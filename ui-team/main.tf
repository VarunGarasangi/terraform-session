module "vpc" {
  source         = "../vpc"
  vpc_name       = "ui-team-vpc"
  vpc_cidr       = "10.1.0.0/16"
  public_subnets = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
  
  
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "custom" {
    depends_on = [ aws_s3_bucket.custom ]
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets_ids[0] # Place instance in the first public subnet

  tags = {
    Name = "UI-Team-Instance"
  }

}

resource "aws_s3_bucket" "custom" {
  bucket = "ui-team-bucket-unique-name-12345" # Bucket names must be globally unique

  tags = {
    Name = "UI-Team-Bucket"
  }
  
}

resource "aws_s3_bucket" "custom2" {
  bucket = "ui-team-bucket-unique-name-12345" # Bucket names must be globally unique

  
    
  }
  


 