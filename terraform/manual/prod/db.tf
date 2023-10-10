module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier              = "${local.resources_prefix}-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  family                  = "mysql8.0"
  major_engine_version    = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 5
  backup_retention_period = 0

  db_name  = var.project
  username = var.db_username
  port     = 3306

  create_db_option_group    = false
  create_db_parameter_group = false
  db_subnet_group_name      = module.vpc.database_subnet_group
  vpc_security_group_ids    = [module.db_access_sg.security_group_id]

  tags = merge(
    var.tags,
    {
      project      = var.project
      environment  = var.environment
    }
  )
}

module "db_access_sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "rds_db_sg"
  description = "RDS MySQL security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = merge(
    var.tags,
    {
      project      = var.project
      environment  = var.environment
    }
  )
}
