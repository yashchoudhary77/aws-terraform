# Output for count

# output "ec2_public_ip" {
#   value = aws_instance.my_instance[*].public_ip    # [*] is used to get the output for multiple resources
# }

# output "ec2_public_dns" {
#   value = aws_instance.my_instance[*].public_dns
# }

# output "ec2_private_ip" {
#   value = aws_instance.my_instance[*].private_ip
# }


# Outputs for each
output "ec2_public_ip" {
  value = [
    for instance in aws_instance.my_instance : instance.public_ip
  ]
}