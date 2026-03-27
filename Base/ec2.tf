resource "aws_instance" "demo-ec2" {
    count = 2
    ami = data.aws_ami.ubuntu.id
    instance_type = var.machine_type
    vpc_security_group_ids = ["aws_security_group.sg.id"]
    subnet_id = var.subnet_id[count.index]
    associate_public_ip_address = true
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    tags = merge(var.common_tags,
        {
      Name = "demo-ec2-${count.index + 1}"
    })
   
}