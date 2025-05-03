module "network_acl" {
  source   = "../../modules/networks/network-acl"
  for_each = { for acl in var.nacl_list : acl.name => acl }

  vpc_id        = module.vpc.vpc_id
  subnet_ids    = each.value.name == "public" ? local.subnet_ids_by_type.public : local.subnet_ids_by_type.private
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
  tags          = merge(var.tags, { Name = "${var.tags.Name}-${each.value.name}-network-acl" })
}
