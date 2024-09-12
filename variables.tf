variable "db_master_username" {
    description = "the database master username"
    type = string
}

variable "db_master_password" {
    description = "the database master password"
    type = string
    sensitive = true
}

variable "instance_type" {
}

variable "aws_region" {
  type = string
}

variable "availability_zone" {
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type = string
  sensitive = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type = string
  sensitive = true
}

variable "vpc_id" {  
}

variable "db_subnet_group_name" {
}

variable "cidr_blocks" {
  description = "list of allowed cidr blocks"
  type = list(string)
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 and RDS instance"
  type = string
}

variable "subnet_cidr" {
  description = "ec2 subnet cidr"
}

variable "cidr_block" {
    description = "vpc cidr"
}

variable "ami" {
  description = "AMI for the EC2 instance"
  type = string
}

variable "storage_type" {  
}

variable "engine" { 
}

variable "engine_version" { 
}

variable "instance_class" {  
}

variable "public_key" {
  description = "The key name to use to access the ec2 instance"
  type = string
}

variable "key_name" {
}

variable "iam_instance_profile" {
  description = "The IAM instance profile name to associate with the EC2 instance"
  type = string
}

variable "region" {
  description = "The AWS region"
  type = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type = string
}

variable "public_subnet_cidr_blocks" { 
  description = "List of CIDR blocks for public subnets"
}

variable private_subnet_cidr_blocks {
  description = "List of CIDR blocks for private subnets"
  type = list(string)
}

variable "subnets" {
  description = "The subnets for the EKS cluster"
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  type    = list(string)
  description = "A list of subnet IDs for the control plane. Must be spread across at least two AZs."
}

variable "subnet_ids" {
  description = "The subnet IDs for the EKS cluster"
  type        = list(string)
}