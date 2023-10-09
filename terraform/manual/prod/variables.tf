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

variable "tags" {
  type    = map(string)
  default = {
    team                = "devops"
    repository          = "maks_new_challenge"
    terraform_managed   = "true"
  }
}
