output "organization_id" {
  description = "The AWS Organizations organization ID."
  value       = module.organization.organization_id
}

output "organizational_unit_ids" {
  description = "Map of OU name to OU ID."
  value       = module.organization.organizational_unit_ids
}

output "hub_vpc_id" {
  description = "ID of the hub VPC."
  value       = module.networking.hub_vpc_id
}

output "transit_gateway_id" {
  description = "ID of the Transit Gateway connecting hub and spokes."
  value       = module.networking.transit_gateway_id
}

output "spoke_vpc_ids" {
  description = "Map of spoke name to VPC ID."
  value       = module.networking.spoke_vpc_ids
}

output "log_bucket_name" {
  description = "Centralized logging S3 bucket name."
  value       = module.logging.log_bucket_name
}

output "cloudtrail_arn" {
  description = "ARN of the organization CloudTrail."
  value       = module.logging.cloudtrail_arn
}

output "guardduty_detector_id" {
  description = "GuardDuty detector ID (null when disabled)."
  value       = module.security.guardduty_detector_id
}
