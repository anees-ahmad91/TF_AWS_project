# create postgresSQL RDS instance
resource "aws_db_instance" "postgresSQL" {
  allocated_storage    = 20
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_subnet_group_name = var.db_subnet_group_name
  username             = var.db_master_username
  password             = var.db_master_password
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

tags = {
  Name = "My-Postgressql-DB"
  }
}

# create rds security group
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

tags = {
  Name = "My-RDS-Security-Group"
}

}

data "aws_availability_zone" "available" {
    name = "eu-west-1a"
  
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
