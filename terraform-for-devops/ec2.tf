# Creating an EC2 instance

# 1st creating key pair
resource "aws_key_pair" "my_key" {
  key_name   = "terra-ec2-keypair"
  public_key = file("terra-ec2-keypair.pub")
}

# 2nd Creating VPC and security groups
resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "my_security_group" {
  name        = "automated-sg"
  description = "This will add a TF generated SG"
  vpc_id      = aws_default_vpc.default.id #interpolation

  #Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #List
    description = "SSH Open"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Open"
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Anyone can reacj to this server via port 8000"
  }

  #Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "This server can reach anywhere"
  }

  tags = {
    Name = "automated-sg"
  }
}

# 3rd Creating EC2 intance
resource "aws_instance" "my_instance" {
  #count = 2       # Number of resources will be created (it is a meta argument)

  for_each = tomap ({                 # for_each = tomap ({}) is a meta argument to map key value pair
    terra-server-1 = "t3.micro",      # it can be used later via each.key/value keyword
    terra-server-2 = "t3.small"
  })

  depends_on = [aws_security_group.my_security_group]  # ec2 instance will be not be created until the security group is created

  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name] #List
  # instance_type   = var.ec2_instace_type

  instance_type = each.value
  ami = var.aws_ami_id #Ubuntu (here ami = OS) # Need to check this images is from provider and this is fixed

  user_data = file("installation.sh") # user_data is an optional argument that allows to run some commands at startup

  # root_block_device {
  #   volume_size = var.ec2_root_storage_size
  #   volume_type = "gp3"
  # }

  root_block_device {
    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage_size     # Conditional statement (ternary operator)
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}

# now taking the server from cloud to Terrafrom to manage it from terraform
# resource "aws_instance" "my_new_instance" {
#   ami = "unknown"
#   instance_type = "unknown"

# }