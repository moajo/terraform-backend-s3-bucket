output "bucket" {
  value       = aws_s3_bucket.main
  description = "Created aws_s3_bucket."
}

output "kms_key" {
  value       = aws_kms_key.main
  description = "Created aws_kms_key to encrypt the bucket."
}
