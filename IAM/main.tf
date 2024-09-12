# create an IAM role for SSM access
resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2_ssm_role"

assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# attach policy to the IAM role for SSM
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# create IAM SSM instance profile for EC2 instance 
resource "aws_iam_instance_profile" "ec2_ssm_instance_profile2" {
  name = "ec2_ssm_instance_profile2"
  role = aws_iam_role.ec2_ssm_role.name
}
