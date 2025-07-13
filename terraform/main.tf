provider "aws" {
  region = "ap-south-1"
}

# SSH Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(var.public_key_path)
}

# Security Group with SSH and HTTP access
resource "aws_security_group" "allow_web_ssh" {
  name        = "allow_web_ssh"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id  # << Replace with your actual VPC ID

  ingress = [
    {
      description      = "Allow SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

# EC2 Instance
resource "aws_instance" "devops_portfolio" {
  ami                    = var.ami_id  # Amazon Linux 2 (ap-south-1)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  subnet_id              = var.subnet_id  # << Replace with your actual Subnet ID
  vpc_security_group_ids = [aws_security_group.allow_web_ssh.id]
  user_data              = file("userdata.sh")

  tags = {
    Name = "DevOps-Portfolio-Server"
  }
}
