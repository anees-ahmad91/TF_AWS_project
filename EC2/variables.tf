variable "instance_type" {
}

variable "availability_zone" {  
}

variable "vpc_id" {
  
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 and RDS instance"
  type = string

}

variable "ami" {
  description = "AMI for the EC2 instance"
  type = string

}

//variable "key_name" {
  //description = "The key name to use to connect to the instance"
 // type = string

//}

variable "iam_instance_profile" {
  description = "The IAM instance profile name to associate with the EC2 instance"
  type = string
}

variable "region" {
  
}