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
resource "aws_key_pair" "deployer" {
    key_name   = "HP"
    public_key = file("C:/Users/HP/.ssh/HP.pub")
  
}

resource "aws_instance" "custom" {
    depends_on = [ aws_key_pair.deployer ]
    
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "HP"
    vpc_security_group_ids = [aws_security_group.main.id]
  

  tags = {
    Name = "remote-provisioner-instance"
  }

}
resource "null_resource" "remote_provisioner" {
    depends_on = [ aws_instance.custom ]
    connection {
      type = "ssh"
    user = "ubuntu"
     private_key =file("C:/Users/HP/.ssh/HP")
    host = aws_instance.custom.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "touch hello.txt",
            "echo 'Hello, World!' >> hello.txt"
            
        ]
    }
  
}