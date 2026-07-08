variable "aws_region" {
  description = "Primary AWS region for the landing zone."
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name (dev, prod)."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owning team or business unit for resource tagging."
  type        = string
  default     = "platform-engineering"
}

variable "organization_units" {
  description = "Top-level Organizational Units to create under the root."
  type        = list(string)
  default     = ["Security", "Infrastructure", "Workloads", "Sandbox"]
}

variable "accounts" {
  description = "Member accounts to create, keyed by account alias."
  type = map(object({
    email = string
    ou    = string
  }))
  default = {}
}

variable "enable_scp" {
  description = "Attach baseline Service Control Policies to the root."
  type        = bool
  default     = true
}

variable "hub_vpc_cidr" {
  description = "CIDR block for the hub (inspection/egress) VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "spoke_vpc_cidrs" {
  description = "CIDR blocks for spoke VPCs keyed by name."
  type        = map(string)
  default = {
    shared   = "10.1.0.0/16"
    workload = "10.2.0.0/16"
  }
}

variable "availability_zones" {
  description = "Availability zones to spread subnets across."
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "log_retention_days" {
  description = "Retention period, in days, for centralized logs."
  type        = number
  default     = 365
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
