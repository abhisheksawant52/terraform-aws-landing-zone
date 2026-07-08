resource "aws_ec2_transit_gateway" "this" {
  description                     = "${var.name_prefix}-tgw"
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "${var.name_prefix}-tgw"
  }
}

# Hub VPC (centralized egress / inspection)
resource "aws_vpc" "hub" {
  cidr_block           = var.hub_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-hub"
    Tier = "hub"
  }
}

resource "aws_subnet" "hub" {
  for_each = { for idx, az in var.availability_zones : az => idx }

  vpc_id            = aws_vpc.hub.id
  availability_zone = each.key
  cidr_block        = cidrsubnet(var.hub_vpc_cidr, 4, each.value)

  tags = {
    Name = "${var.name_prefix}-hub-${each.key}"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "hub" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = aws_vpc.hub.id
  subnet_ids         = [for s in aws_subnet.hub : s.id]

  tags = {
    Name = "${var.name_prefix}-hub-attach"
  }
}

# Spoke VPCs
resource "aws_vpc" "spoke" {
  for_each = var.spoke_vpc_cidrs

  cidr_block           = each.value
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-${each.key}"
    Tier = "spoke"
  }
}

resource "aws_subnet" "spoke" {
  for_each = {
    for pair in flatten([
      for name, cidr in var.spoke_vpc_cidrs : [
        for idx, az in var.availability_zones : {
          key  = "${name}-${az}"
          name = name
          az   = az
          idx  = idx
        }
      ]
    ]) : pair.key => pair
  }

  vpc_id            = aws_vpc.spoke[each.value.name].id
  availability_zone = each.value.az
  cidr_block        = cidrsubnet(var.spoke_vpc_cidrs[each.value.name], 4, each.value.idx)

  tags = {
    Name = "${var.name_prefix}-${each.value.key}"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "spoke" {
  for_each = var.spoke_vpc_cidrs

  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = aws_vpc.spoke[each.key].id
  subnet_ids         = [for k, s in aws_subnet.spoke : s.id if s.vpc_id == aws_vpc.spoke[each.key].id]

  tags = {
    Name = "${var.name_prefix}-${each.key}-attach"
  }
}

# Default route from each spoke to the Transit Gateway (hub egress path)
resource "aws_route" "spoke_default" {
  for_each = var.spoke_vpc_cidrs

  route_table_id         = aws_vpc.spoke[each.key].default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.this.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.spoke]
}
