module "nat_gateway" {
  source        = "../../modules/networks/nat-gateway"
  allocation_id = module.eip.eip_allocation_id
  subnet_id     = local.subnet_ids_by_type.public[0]
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}"
    }
  )
}
