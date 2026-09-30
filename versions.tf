terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.66"
    }
  }

  # Remote state backend. Configure per environment with a partial backend:
  #   terraform init -backend-config=environments/dev/backend.hcl
  #
  # backend "s3" {
  #   bucket         = "acme-landing-zone-tfstate"
  #   key            = "landing-zone/terraform.tfstate"
  #   region         = "eu-west-1"
  #   dynamodb_table = "acme-landing-zone-tflock"
  #   encrypt        = true
  # }
}
