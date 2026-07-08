variable "organization_units" {
  description = "Top-level Organizational Units to create under the root."
  type        = list(string)
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
  description = "Create and attach baseline Service Control Policies."
  type        = bool
  default     = true
}
