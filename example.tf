module "cluster" {
  source     = "./modules/ecs-cluster"
  aws_region = "eu-west-2"
  key_name   = "mbp"
}

module "l4d" {
  source         = "./modules/ecs-service"
  aws_region     = "eu-west-2"
  cluster        = module.cluster.cluster_name
  log_group_name = module.cluster.log_group_name
  security_group = module.cluster.security_group_id
  game           = "l4d"
  port           = 27016
  trusted_cidr   = local.home_ip
  steam_group    = local.steam_group
  rcon_password  = local.rcon_password
}

module "l4d2" {
  source         = "./modules/ecs-service"
  aws_region     = "eu-west-2"
  cluster        = module.cluster.cluster_name
  log_group_name = module.cluster.log_group_name
  security_group = module.cluster.security_group_id
  trusted_cidr   = local.home_ip
  steam_group    = local.steam_group
  rcon_password  = local.rcon_password
}
