variable "name_prefix" {
  description = "Prefix applied to logging resource names."
  type        = string
}

variable "log_retention_days" {
  description = "Retention period, in days, before logs expire."
  type        = number
  default     = 365
}
