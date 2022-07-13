module "vpc" {
  source              = "./modules/vpc"
  env                 = var.env
  app_name            = var.app_name
  region              = var.region
  az_list             = var.az_list
  vpc_cidr_block      = var.vpc_cidr_block
  private_cidr_blocks = var.private_cidr_blocks
  public_cidr_blocks  = var.public_cidr_blocks
}

# Launch Jump-server and Appliation Web Server
module "ec2" {
  source              = "./modules/ec2"
  env                 = var.env
  app_name            = var.app_name
  instance_type       = var.instance_type
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_subnet_ids   = module.vpc.public_subnet_ids
  app_vpc_id          = module.vpc.app_vpc_id
  private_cidr_blocks = var.private_cidr_blocks
  key_name            = var.key_name
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  time_zone           = var.time_zone
  az_list             = var.az_list
}
