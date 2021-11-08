terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  acl    = "private"

  // NOTE: It is recommended to enable versioning for the terraform backend bucket.
  // see: https://www.terraform.io/docs/language/settings/backends/s3.html
  versioning {
    enabled = true
  }

  // NOTE: Use SSE-KMS so that you can control permissions in detail.
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.main.key_id
        sse_algorithm     = "aws:kms"
      }
      bucket_key_enabled = true
    }
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = var.bucket_name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSSLRequestsOnly",
        "Principal" : "*",
        "Effect" : "Deny",
        "Action" : "s3:*",
        "Resource" : [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ],
        "Condition" : {
          "Bool" : {
            "aws:SecureTransport" : "false"
          }
        },
      },
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [
    aws_s3_bucket_policy.main
  ]
}

data "aws_caller_identity" "current" {}
resource "aws_kms_key" "main" {
  enable_key_rotation = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "allow-all-user",
    "Statement" : [
      {
        "Sid" : "AllowAllUsers",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            data.aws_caller_identity.current.account_id
          ]
        },
        "Action" : "kms:*",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_kms_alias" "main" {
  name          = "alias/s3-terraform"
  target_key_id = aws_kms_key.main.key_id
}
