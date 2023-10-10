module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name = local.resources_prefix

  cluster_arn       = local.cluster_arn
  platform_version  = var.ecs_platform_version
  subnet_ids        = local.public_subnet_ids
  assign_public_ip  = true

  load_balancer = {
    "0" = {
      target_group_arn = module.alb.target_group_arns[0]
      #elb_name         = module.alb.lb_dns_name
      container_name   = local.container_name
      container_port   = var.container_port
    }
  }

  create_task_definition = true

  container_definitions = {
    "${local.container_name}" = {
      cpu       = 512
      memory    = 1024
      essential = true
      image     = "${local.ecr_repository_name}:${var.image_tag}"
      port_mappings = [
        {
          name          = local.container_name
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
    }
  }

  enable_autoscaling   = true
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 3

  create_security_group = true
  security_group_rules = {
    "egress_all" = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = merge(
    var.tags,
    {
      project      = var.project
      environment  = var.environment
    }
  )
}