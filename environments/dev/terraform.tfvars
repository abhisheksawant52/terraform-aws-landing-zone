aws_region  = "eu-west-1"
environment = "dev"
owner       = "platform-engineering"

organization_units = ["Security", "Infrastructure", "Workloads", "Sandbox"]

accounts = {
  sandbox-dev = {
    email = "aws+sandbox-dev@example.com"
    ou    = "Sandbox"
  }
}

enable_scp = true

hub_vpc_cidr = "10.0.0.0/16"
spoke_vpc_cidrs = {
  shared   = "10.1.0.0/16"
  workload = "10.2.0.0/16"
}
availability_zones = ["eu-west-1a", "eu-west-1b"]

log_retention_days = 90
enable_guardduty   = true
enable_config      = true
