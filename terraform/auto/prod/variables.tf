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

variable "tags" {
  type    = map(string)
  default = {
    team                = "devops"
    repository          = "maks_new_challenge"
    terraform_managed   = "true"
  }
}
