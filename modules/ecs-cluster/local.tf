locals {
  vpc_id     = var.vpc_id == "" ? data.aws_vpcs.all.ids[0] : var.vpc_id
  subnet_ids = length(var.subnets) == 0 ? data.aws_subnets.any.ids : var.subnets
}