# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "root" {
  cidr_block                           = var.cidr_block
  instance_tenancy                     = var.instance_tenancy
  enable_dns_support                   = var.enable_dns_support
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  enable_dns_hostnames                 = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block     = var.ipv6_ipam_pool_id == null ? true : null
  ipv6_cidr_block                      = var.ipv6_ipam_pool_id != null ? var.ipv6_cidr_block : null
  ipv6_ipam_pool_id                    = var.ipv6_ipam_pool_id
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-vpc"
    }
  )
}
