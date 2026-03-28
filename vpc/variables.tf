variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
    default     = "my-vpc"
  
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
  
}
 
 variable "public_subnets" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string)
    
   
 }

 