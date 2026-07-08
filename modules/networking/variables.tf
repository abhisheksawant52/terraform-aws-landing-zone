variable "name_prefix" {
  description = "Prefix applied to networking resource names."
  type        = string
}

variable "hub_vpc_cidr" {
  description = "CIDR block for the hub VPC."
  type        = string
}

variable "spoke_vpc_cidrs" {
  description = "Map of spoke VPC name to CIDR block."
  type        = map(string)
}

variable "availability_zones" {
  description = "Availability zones to spread subnets across."
  type        = list(string)
}
