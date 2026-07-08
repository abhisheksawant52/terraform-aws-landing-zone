output "transit_gateway_id" {
  description = "Transit Gateway ID."
  value       = aws_ec2_transit_gateway.this.id
}

output "hub_vpc_id" {
  description = "Hub VPC ID."
  value       = aws_vpc.hub.id
}

output "spoke_vpc_ids" {
  description = "Map of spoke name to VPC ID."
  value       = { for k, v in aws_vpc.spoke : k => v.id }
}

output "hub_subnet_ids" {
  description = "Hub subnet IDs."
  value       = [for s in aws_subnet.hub : s.id]
}
