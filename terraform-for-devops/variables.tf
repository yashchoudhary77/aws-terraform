variable "ec2_instace_type" {
  default = "t3.micro"
  type    = string
}

# variable "ec2_root_storage_size" {
#   default = 15
#   type    = number
# }

variable "ec2_default_root_storage_size" {
  default = 10
  type    = number
}

variable "aws_ami_id" {
  default = "ami-07a00cf47dbbc844c" #ubuntu
  type    = string
}

# Conditional Statement
variable "env" {
  default = "prod"
  type = string
}