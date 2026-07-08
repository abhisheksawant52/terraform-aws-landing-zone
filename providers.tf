provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      ManagedBy   = "terraform"
      Project     = "landing-zone"
      Environment = var.environment
      Owner       = var.owner
    }
  }
}
