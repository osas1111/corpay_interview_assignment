module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws//modules/cluster"

  cluster_name = local.resources_prefix

  create_cloudwatch_log_group = true
  create_task_exec_iam_role   = true

  tags = merge(
    var.tags,
    {
      project      = var.project
      environment  = var.environment
    }
  )
}
