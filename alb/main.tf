
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name               = var.alb_name
  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  subnets         = var.subnets
  security_groups = [aws_security_group.alb_sg.id]

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "tg1"
      }
    }
  }
target_groups = {
  tg1 = {
    name        = "ex-tg"
    protocol    = "HTTP"
    port        = 80
    target_type = "instance"

    health_check = {
      path = "/"
    }

    targets = [
      {
        target_id = aws_instance.web.id
        port      = 80
      }
    ]
  }
}

  
}
