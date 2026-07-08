.DEFAULT_GOAL := help
ENV ?= dev
.PHONY: help init fmt fmt-check validate plan lint clean

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}'

init: ## Initialize Terraform without a backend
	terraform init -backend=false

fmt: ## Format all Terraform files in place
	terraform fmt -recursive

fmt-check: ## Check formatting (CI)
	terraform fmt -check -recursive

validate: ## Validate the root module
	terraform init -backend=false
	terraform validate

plan: ## Plan for an environment (make plan ENV=dev|prod)
	terraform plan \
		-var-file=environments/$(ENV)/terraform.tfvars

lint: ## Run tflint across all modules
	tflint --recursive

clean: ## Remove local Terraform caches and plans
	find . -type d -name .terraform -prune -exec rm -rf {} +
	find . -type f \( -name '*.tfstate*' -o -name 'tfplan' -o -name 'plan.out' \) -delete
