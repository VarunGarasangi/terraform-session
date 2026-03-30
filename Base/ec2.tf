
resource "aws_instance" "Demo-ec2" {
  count                  = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.machine_type
  vpc_security_group_ids = [aws_security_group.app-sg.id]
  subnet_id              = "subnet-024195e2be5f8d333"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = merge(var.common_tags,
    {
      Name = "Demo-EC2-${count.index + 1}"
  })

}