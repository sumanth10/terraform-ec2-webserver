locals {
  account_id = data.aws_caller_identity.current.account_id # This parameter is useful if you want to add multiple accounts
  region = data.aws_region.current.name
  tags = merge(
    {
      module-usage = "internal"
    }
  )
}

data "aws_caller_identity" "current" {
  
}

data "aws_region" "current" {
  
}

data "aws_availability_zones" "availiable" {
  
}