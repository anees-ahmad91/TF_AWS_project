variable "vpc_id" {
  
}

variable "db_subnet_group_name" {
  
}

variable "subnet_cidr" {
  description = "ec2 subnet cidr"
}

variable "cidr_block" {
    description = "vpc cidr"
  
}

variable "aws_region" {
  type = string
  
}

variable "region" {
  description = "The AWS region"
  type = string
}

variable "cluster_version" {
}

variable "public_subnet_cidr_blocks" {
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable private_subnet_cidr_blocks {
  type = list(string)
}