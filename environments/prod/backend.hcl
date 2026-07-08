bucket         = "acme-landing-zone-tfstate-prod"
key            = "landing-zone/prod/terraform.tfstate"
region         = "eu-west-1"
dynamodb_table = "acme-landing-zone-tflock-prod"
encrypt        = true
