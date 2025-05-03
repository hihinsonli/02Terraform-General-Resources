module "subnets" {
  source                          = "../../modules/networks/subnet"
  for_each                        = { for subnet in var.subnets_list : subnet.cidr_block => subnet }
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  availability_zone               = each.value.az
  cidr_block                      = each.value.cidr_block
  enable_dns64                    = var.enable_dns64
  ipv6_cidr_block                 = var.ipv6_cidr_block
  ipv6_native                     = var.ipv6_native
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  vpc_id                          = module.vpc.vpc_id
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-subnet-${each.value.type}-${substr(each.value.az, -1, 1)}"
    }
  )
}
