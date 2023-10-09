output "vpc_id" {
  description = "VPC Id"
  value       = try(module.vpc.vpc_id, "")
}

output "public_subnet_ids" {
  description = "List of Public Subnet Ids associated with the VPC"
  value       = try(module.vpc.public_subnets, [])
}

output "private_subnets_cidr_blocks" {
  description = "List of Private Subnet CIDRs associated with the VPC"
  value       = try(module.vpc.private_subnets_cidr_blocks, [])
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  value       = try(module.ecs_cluster.arn, "")
}
