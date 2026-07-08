locals {
  name_prefix = "lz-${var.environment}"
}

module "organization" {
  source = "./modules/organization"

  organization_units = var.organization_units
  accounts           = var.accounts
  enable_scp         = var.enable_scp
}

module "logging" {
  source = "./modules/logging"

  name_prefix        = local.name_prefix
  log_retention_days = var.log_retention_days
}

module "networking" {
  source = "./modules/networking"

  name_prefix        = local.name_prefix
  hub_vpc_cidr       = var.hub_vpc_cidr
  spoke_vpc_cidrs    = var.spoke_vpc_cidrs
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"

  name_prefix       = local.name_prefix
  enable_guardduty  = var.enable_guardduty
  enable_config     = var.enable_config
  config_bucket_arn = module.logging.log_bucket_arn
}
