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

variable "container_port" {
  type    = number
  default = 3000
}

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "ecs_platform_version" {
  type    = string
  default = "1.3.0"
}

variable "rails_env" {
  type    = string
  default = null
}

variable "db_user" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_port" {
  type    = string
  default = 3306
}

variable "db_host" {
  type    = string
  default = null
}

variable "db_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {
    team                = "devops"
    repository          = "maks_new_challenge"
    terraform_managed   = "true"
  }
}
