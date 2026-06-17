resource "aws_s3_bucket" "remote_S3" {
  bucket = "my-remote-state-s3-bucket"

  tags = {
    Name        = "my-remote-state-s3-bucket"
  }
}