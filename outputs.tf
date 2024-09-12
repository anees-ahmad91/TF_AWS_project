output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet" {
  value= module.vpc.public_subnet
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "cluster_security_group_id" {
  value = module.vpc.eks_cluster_sg
}