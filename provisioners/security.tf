resource "aws_security_group" "main" {
    egress = [
        {
            cidr_blocks = ["0.0.0.0/0"]
            description = "Allow all outbound traffic"
            from_port   = 0
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids = []
            protocol    = "-1"
            security_groups = []
            self        = false
            to_port     = 0

        }
    ]
  ingress = [
    {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH from anywhere"
        from_port   = 22
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = []
        protocol    = "tcp"
        security_groups = []
        self        = false
        to_port     = 22
    }
  ]
}