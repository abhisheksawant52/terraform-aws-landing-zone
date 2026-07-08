output "organization_id" {
  description = "The organization ID."
  value       = aws_organizations_organization.this.id
}

output "root_id" {
  description = "The organization root ID."
  value       = aws_organizations_organization.this.roots[0].id
}

output "organizational_unit_ids" {
  description = "Map of OU name to OU ID."
  value       = { for k, v in aws_organizations_organizational_unit.this : k => v.id }
}

output "account_ids" {
  description = "Map of account alias to account ID."
  value       = { for k, v in aws_organizations_account.member : k => v.id }
}
