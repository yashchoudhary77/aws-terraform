resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "dynamoDB-state-table"
  billing_mode   = "PAY_PER_REQUEST"        # If used PROVISIONED then we have to pay for whole month
#   read_capacity  = 20       # Can't specify these two attributes as we are using on demand service
#   write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamoDB-state-table"
  }
}