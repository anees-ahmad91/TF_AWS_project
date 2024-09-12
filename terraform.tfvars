db_master_username = "anees_1991"

db_master_password = "Sp1d3rman"

instance_type = "t3.micro"

aws_region = ""

availability_zone = "eu-west-1d"

aws_access_key = ""

aws_secret_key = ""

vpc_id = "aws_vpc.main.id"

db_subnet_group_name = "rds_subnet_group"

cidr_blocks = [ "10.0.0.0/16" ]

subnet_id = "aws_subnet.private.id"

subnet_cidr = "10.0.1.0/24"

cidr_block = "10.0.0.0/16"

ami = "ami-0d191299f2822b1fa"

storage_type = "gp2"

engine = "postgres"

engine_version = "16.2"

instance_class = "db.t3.micro"

key_name = "ec2-key"

public_key = "tls_private_key"

//security_group_ids = [ "ec2_sg_id" ]

iam_instance_profile = "ec2_ssm_instance_profile"

region = "eu-west-1"

cluster_name = "my-eks-cluster"

cluster_version = "1.30"

public_subnet_cidr_blocks = "10.0.1.0/24"

private_subnet_cidr_blocks = ["10.0.2.0/24", "10.0.3.0/24"]

subnets = [ "aws_subnet_private[*].id" ]

control_plane_subnet_ids = []

subnet_ids = []