module "alb" {
  source  = "terraform-aws-modules/alb/aws"

  name = local.resources_prefix

  load_balancer_type = "application"

  vpc_id          = local.vpc_id
  subnets         = local.public_subnet_ids
  security_groups = [module.alb_sg.security_group_id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
    }
  ]

  target_groups = [
    {
      name             = local.resources_prefix
      backend_protocol = "HTTP"
      backend_port     = var.container_port
      target_type      = "ip"
    }
  ]

  tags = merge(
    var.tags,
    {
      project      = var.project
      environment  = var.environment
    }
  )
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "${local.resources_prefix}-alb-sg"
  description = "Load balancer security group"
  vpc_id      = local.vpc_id

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = local.private_subnets_cidr_blocks

  tags = merge(
    var.tags,
    {
      project      = var.project
      environment  = var.environment
    }
  )
}
