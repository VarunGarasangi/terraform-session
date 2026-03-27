

resource "aws_security_group" "app-sg" {
  name        = "app-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_ip_range
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = var.common_tags
}



resource "aws_security_group_rule" "allow_http_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = var.private_subnet_ip_range
  security_group_id = aws_security_group.app-sg.id

}