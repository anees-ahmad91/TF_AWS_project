variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster is deployed"
  type        = string
}

variable "instance_type" {
}

variable "control_plane_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  type        = list(string)
}

variable "cluster_sg_id" {
  description = "ID of the EKS cluster security group"
  type        = string
}

variable "cluster_version" {
}

variable "subnets" {
  description = "The subnets for the EKS cluster"
  type        = list(string)
}