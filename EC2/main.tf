resource "aws_instance" "ec2_instance" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  security_groups = [aws_security_group.ec2_sg.id]
  iam_instance_profile = var.iam_instance_profile

user_data = <<-EOF
              #!/bin/bash

              sudo yum update -y

              # Install PostgreSQL 13 client from Amazon Linux Extras
              sudo amazon-linux-extras install -y postgresql13

              # Install SSM Agent 
              sudo yum install -y amazon-ssm-agent
              sudo systemctl start amazon-ssm-agent
              sudo systemctl enable amazon-ssm-agent
              EOF

  tags = {
    Name = "my-postgresql-ec2-client"
  }
}

resource "aws_security_group" "ec2_sg" {
  
  name        = "ec2_sg"
  description = "Allow all inbound/outbound SSM traffic"
  vpc_id = var.vpc_id

  ingress = [{
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow inbound traffic on port 443"
  ipv6_cidr_blocks = []
  prefix_list_ids = []
  security_groups = []
  self = false
  }
   ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow all inbound/outbound EC2 traffic"
  }
}

 # create VPC endpoints for SSM access
resource "aws_vpc_endpoint" "ssm" {
  vpc_id = var.vpc_id
  service_name = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = [var.subnet_id]
  security_group_ids = [aws_security_group.ec2_sg.id]
  private_dns_enabled = true


  tags = {
    Name = "SSM Endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id = var.vpc_id
  service_name = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [var.subnet_id]
  security_group_ids = [aws_security_group.ec2_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "EC2 Messages Endpoint"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [var.subnet_id]
  security_group_ids = [aws_security_group.ec2_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "SSM Messages Endpoint"
  }
}
