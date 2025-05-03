# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "root" {
  vpc_id = var.vpc_id
  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                 = try(route.value.cidr_block, null)
      ipv6_cidr_block            = try(route.value.ipv6_cidr_block, null)
      destination_prefix_list_id = try(route.value.destination_prefix_list_id, null)
      gateway_id                 = try(route.value.gateway_id, null)
      egress_only_gateway_id     = try(route.value.egress_only_gateway_id, null)
      nat_gateway_id             = try(route.value.nat_gateway_id, null)
      transit_gateway_id         = try(route.value.transit_gateway_id, null)
      vpc_peering_connection_id  = try(route.value.vpc_peering_connection_id, null)
      network_interface_id       = try(route.value.network_interface_id, null)
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-route-table"
    }
  )
}

# Associate public subnets with public route table
resource "aws_route_table_association" "subnet_route" {
  for_each       = var.subnet_route_associations_map
  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.root.id
}
