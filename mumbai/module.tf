module "my-demo" {
    source = "../Base"
    vpc_name = "demo-vpc"
    machine_type = "t2.micro"
   # private_subnet_ip_range = ["172.31.1.0/28", "172.31.2.0/28"]
    subnet_id = ["aws_subnet.private_subnet1.id", "aws_subnet.private_subnet2.id"]
    iam_instance_profile = "aws_iam_instance_profile.ec2_role.name"
      
      
    
}