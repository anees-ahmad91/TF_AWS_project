variable "db_master_username" {

}
variable "db_master_password" {
    
    description = "the database master password"
    type = string
    sensitive = true
}

variable "availability_zone" { 
}

variable "vpc_id" { 
}

variable "db_subnet_group_name" {
  
}

variable "cidr_blocks" {
  description = "list of allowed cidr blocks"
  type = list(string)
}

variable "storage_type" {
  
}

variable "engine" {
  
}

variable "engine_version" {
  
}

variable "instance_class" {
  
}
