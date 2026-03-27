variable "vpc_name" {
  description = "Name of the VPC to use"
  type        = string
  default     = "demo-vpc"

}

variable "machine_type" {
  description = "Type of the EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

variable "private_subnet_ip_range" {
  description = "CIDR block for the private subnet"
  type        = list(string)
  default     = ["172.31.1.0/28", "172.31.2.0/28"]

}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Demo"
    Project     = "Terraform-Sessions"
    team        = "DevOps"
  }

}

variable "public_ip" {
  description = "Whether to assign a public IP to the EC2 instances"
  type        = bool
  default     = true

}

variable "count_s3" {
  description = "Number of S3 buckets to create"
  type        = number
  default     = 0

}

variable "usernames" {
  description = "list of IAM user to create"
  type        = list(string)
  default     = ["varun", "kiran", "sourabh"]

}
variable "iam_instance_profile" {
  description = "IAM Instance Profile name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = list(string)
}
  
