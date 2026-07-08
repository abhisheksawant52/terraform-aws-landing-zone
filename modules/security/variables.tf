variable "name_prefix" {
  description = "Prefix applied to security resource names."
  type        = string
}

variable "enable_guardduty" {
  description = "Enable GuardDuty threat detection."
  type        = bool
  default     = true
}

variable "enable_config" {
  description = "Enable AWS Config recorder and delivery channel."
  type        = bool
  default     = true
}

variable "config_bucket_arn" {
  description = "ARN of the S3 bucket AWS Config delivers snapshots to."
  type        = string
}
