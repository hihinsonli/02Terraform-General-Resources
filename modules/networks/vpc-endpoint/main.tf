# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint
resource "aws_vpc_endpoint" "root" {
  vpc_id                     = var.vpc_id
  vpc_endpoint_type          = var.vpc_endpoint_type
  service_name               = var.service_name
  subnet_ids                 = var.subnet_ids != [] ? var.subnet_ids : null
  security_group_ids         = var.security_group_ids
  route_table_ids            = var.route_table_ids
  auto_accept                = var.auto_accept
  policy                     = var.policy
  private_dns_enabled        = var.private_dns_enabled
  ip_address_type            = var.ip_address_type
  service_region             = var.service_region
  resource_configuration_arn = var.resource_configuration_arn
  service_network_arn        = var.service_network_arn
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-vpc-endpoint"
    }
  )

  dynamic "dns_options" {
    for_each = var.dns_options != null ? [var.dns_options] : []
    content {
      dns_record_ip_type                             = dns_options.value.dns_record_ip_type
      private_dns_only_for_inbound_resolver_endpoint = lookup(dns_options.value, "private_dns_only_for_inbound_resolver_endpoint", null)
    }
  }

  dynamic "subnet_configuration" {
    for_each = var.subnet_configuration != null && var.subnet_ids == [] ? [var.subnet_configuration] : []
    content {
      subnet_id = subnet_configuration.value.subnet_id
      ipv4      = lookup(subnet_configuration.value, "ipv4", null)
      ipv6      = lookup(subnet_configuration.value, "ipv6", null)
    }
  }
}
