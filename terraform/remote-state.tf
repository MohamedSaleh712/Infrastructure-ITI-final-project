# --------------S3 bucket--------------#
resource "aws_s3_bucket" "s3_remote_state" {
  bucket = var.s3_remote_state_bucket_name
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    name = var.s3_remote_state_bucket_name
  }
}

# --------------S3 versioning on--------------#
resource "aws_s3_bucket_versioning" "s3_remote_state_versioning_enabled" {
  bucket = var.s3_remote_state_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
  depends_on = [aws_s3_bucket.s3_remote_state]
}

# --------------dynamodb table--------------#
resource "aws_dynamodb_table" "dynamodb_remote_state" {
  name         = var.dynamodb_remote_state_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# --------------terraform Backend--------------#
terraform {
  backend "s3" {
    bucket         = "iti-final-project-backend"
    key            = "iti-final-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamodb_remote_state_table_iti-final"
    encrypt        = true
  }
}