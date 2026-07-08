aws_region  = "eu-west-1"
environment = "prod"
owner       = "platform-engineering"

organization_units = ["Security", "Infrastructure", "Workloads", "Sandbox"]

accounts = {
  security-tooling = {
    email = "aws+security-tooling@example.com"
    ou    = "Security"
  }
  log-archive = {
    email = "aws+log-archive@example.com"
    ou    = "Security"
  }
  shared-services = {
    email = "aws+shared-services@example.com"
    ou    = "Infrastructure"
  }
  workload-prod = {
    email = "aws+workload-prod@example.com"
    ou    = "Workloads"
  }
}

enable_scp = true

hub_vpc_cidr = "10.10.0.0/16"
spoke_vpc_cidrs = {
  shared   = "10.11.0.0/16"
  workload = "10.12.0.0/16"
}
availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

log_retention_days = 730
enable_guardduty   = true
enable_config      = true
