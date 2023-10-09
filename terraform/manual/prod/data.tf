data "aws_availability_zones" "available" {}

locals {
  resources_prefix  = "${var.project}-${var.environment}"
  azs               = slice(data.aws_availability_zones.available.names, 0, 3)
}
