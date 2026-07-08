output "guardduty_detector_id" {
  description = "GuardDuty detector ID (null when disabled)."
  value       = var.enable_guardduty ? aws_guardduty_detector.this[0].id : null
}

output "config_recorder_name" {
  description = "AWS Config recorder name (null when disabled)."
  value       = var.enable_config ? aws_config_configuration_recorder.this[0].name : null
}
