variable "region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "project" {
  type    = string
  default = "blog"
}

variable "vpc_cidr" {
  type    = string
  default = "100.0.0.0/16"
}

variable "db_username" {
  description = "The username for the RDS DB master user"
  type = string
  default = "user"
}

variable "tags" {
  type    = map(string)
  default = {
    team                = "devops"
    repository          = "corpay_interview_assignment"
    terraform_managed   = "true"
  }
}
