output "log_bucket_name" {
  description = "Centralized log bucket name."
  value       = aws_s3_bucket.logs.id
}

output "log_bucket_arn" {
  description = "Centralized log bucket ARN."
  value       = aws_s3_bucket.logs.arn
}

output "kms_key_arn" {
  description = "ARN of the log encryption KMS key."
  value       = aws_kms_key.logs.arn
}

output "cloudtrail_arn" {
  description = "ARN of the organization CloudTrail."
  value       = aws_cloudtrail.org.arn
}
