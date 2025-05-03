module "vpc" {
  source                               = "../../modules/networks/vpc"
  cidr_block                           = var.cidr_block
  instance_tenancy                     = var.instance_tenancy
  ipv6_cidr_block                      = var.ipv6_cidr_block
  enable_dns_support                   = var.enable_dns_support
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  enable_dns_hostnames                 = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block
  tags                                 = var.tags
}
