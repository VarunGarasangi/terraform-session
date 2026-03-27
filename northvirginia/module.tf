module "my-demo" {
    source = "../Base"
    vpc_name = "demo-vpc-north-virginia"
    machine_type = "t2.micro"
    private_subnet_ip_range = ["172.31.0.0/20"]
  
}