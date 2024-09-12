provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  backend "s3" {
    bucket         = "mygithubtestbucket"
    key            = "tfstate"
    region         = "eu-west-1"
    dynamodb_table = "githubtest"
  }
}

module "RDS" {
  source = "./.RDS/"
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password
  availability_zone  = var.availability_zone
  vpc_id             = module.vpc.vpc_id
  db_subnet_group_name = var.db_subnet_group_name
  cidr_blocks        = var.cidr_blocks
  storage_type       = var.storage_type
  engine             = var.engine
  engine_version     = var.engine_version
  instance_class     = var.instance_class
}

module "vpc" {
  source = "./VPC"
  vpc_id = var.vpc_id
  db_subnet_group_name = var.db_subnet_group_name
  subnet_cidr = var.subnet_cidr
  cidr_block = var.cidr_block
  aws_region = var.region
  region = var.aws_region
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  cluster_version = var.cluster_version
  cluster_name = var.cluster_name
}

module "EKS" {
  source = "./EKS"
  subnet_ids = module.vpc.private_subnet_ids
  instance_type = var.instance_type
  cluster_sg_id = module.vpc.eks_cluster_sg
  vpc_id = module.vpc.vpc_id
  cluster_version = var.cluster_version
  cluster_name = var.cluster_name
  subnets = var.subnet_ids
  control_plane_subnet_ids = var.subnet_ids

}

module "IAM" {
  source = "./IAM"
}
