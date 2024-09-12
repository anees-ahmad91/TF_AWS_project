data "aws_availability_zones" "AZs" {
  state = "available"
}

# create vpc resource
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "My_Project_VPC"
  }   
}

# create public and private subnets
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_blocks

  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_blocks[count.index]

  availability_zone = data.aws_availability_zones.AZs.names[count.index]

  tags = {
    Name = "Private-Subnet-${count.index + 1}"
  }
}

# create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

tags = {
    Name = "main-igw"
  }
}

# create public and private route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# create route table associations for public and private subnets/route tables
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = 2
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# create NAT gateway for private subnet EC2 internet access
resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = "NAT Gateway"
  }

  depends_on = [ aws_internet_gateway.igw ]
}

# create elastic IP for nat gateway
resource "aws_eip" "nat_eip" {
}

# create 1st rds subnet resource
resource "aws_subnet" "rds_subnet-a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "My_RDS_Subnet_1_Private"
  }
}

# create 2nd rds subnet resource
resource "aws_subnet" "rds_subnet-b" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "My_RDS_Subnet_2_Private"
  }
  
}

# create rds subnet groups
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = var.db_subnet_group_name

  subnet_ids = [
    aws_subnet.rds_subnet-a.id,
    aws_subnet.rds_subnet-b.id
  ]
  
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-eks-cluster-sg"
  }
}