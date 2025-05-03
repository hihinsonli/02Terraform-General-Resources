module "route-table" {
  source                        = "../../modules/networks/route-table"
  for_each                      = { for rt in local.route_table_list : rt.type => rt }
  vpc_id                        = module.vpc.vpc_id
  routes                        = each.value.routes
  subnet_route_associations_map = each.key == "public" ? local.public_subnet_associations_map : local.private_subnet_associations_map
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-${each.key}-route-table"
    }
  )
}
