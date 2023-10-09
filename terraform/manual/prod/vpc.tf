module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name      = local.resources_prefix
  cidr      = var.vpc_cidr

  azs              = local.azs
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 6)]

  create_database_subnet_group = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_igw          = true
  enable_nat_gateway  = true
  single_nat_gateway  = true

  tags = merge(
    var.tags,
    {
      project      = var.project
      environment  = var.environment
    }
  )
}
