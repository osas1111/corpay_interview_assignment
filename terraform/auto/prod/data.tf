data "terraform_remote_state" "manual_prod" {
  backend = "s3"
  config = {
    bucket = "terraform-states-1234567890"
    key    = "blog/manual/prod/terraform.tfstate"
    region = var.region
  }
}

locals {
  resources_prefix            = "${var.project}-${var.environment}"
  cluster_arn                 = data.terraform_remote_state.manual_prod.outputs.ecs_cluster_arn
  vpc_id                      = data.terraform_remote_state.manual_prod.outputs.vpc_id
  public_subnet_ids           = data.terraform_remote_state.manual_prod.outputs.public_subnet_ids
  private_subnets_cidr_blocks = data.terraform_remote_state.manual_prod.outputs.private_subnets_cidr_blocks
  ecr_repository_name         = data.terraform_remote_state.manual_prod.outputs.ecr_repository_name

  container_name = regex("^.*/(.*)$", local.ecr_repository_name)[0]
}
