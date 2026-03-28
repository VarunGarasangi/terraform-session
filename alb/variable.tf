variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
  default     = "value"

}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
  default     = ["value"]
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "example-alb"
}
