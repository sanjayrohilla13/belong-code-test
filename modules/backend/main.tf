# Creation of S3 Bucket for TF state Management
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "${var.aws_acc_no}-tf-state-bucket"
  tags = {
    Name = "tf-state-bucket"
  }
}

# ACL for the S3 Bucket
resource "aws_s3_bucket_acl" "tf_state_bucket_acl" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  acl    = "private"
}

# Enable Bucket Versioning for the Bucket
resource "aws_s3_bucket_versioning" "tf_state_bucket_version" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server Side Encryption for the Bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_bucket_encryption_conf" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Create Dynamodb table for maintaining the state of the State Lock
resource "aws_dynamodb_table" "tf_state_lock_table" {
  name         = "${var.app_name}-${var.env}-tf-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  # read_capacity  = 20
  # write_capacity = 20
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}