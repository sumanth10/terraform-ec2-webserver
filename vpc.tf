locals {
  availability_zones = data.aws_availability_zones.availiable.names[*]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "${var.env_name}-webservice-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = local.availability_zones
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = []
  enable_nat_gateway   = false
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = local.tags
}
