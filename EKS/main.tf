module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "20.19.0"

  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  control_plane_subnet_ids = var.subnet_ids

  create_node_security_group = false

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size = 2
      max_size = 3
      min_size = 1

      instance_type = "t3.micro"

additional_userata = <<-EOT
        #!/bin/bash
        yum install -y postgresql
      EOT

    }
  }

  enable_irsa = true

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

 # Enable SSM access
  node_security_group_additional_rules = {
    ingress_ssm = {
      description = "Allow SSM access"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
}

