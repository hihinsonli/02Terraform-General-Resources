# Find public subnets and select the first one
locals {
  public_subnets = [for subnet in var.subnets_list : subnet if subnet.type == "public"]

  subnet_ids_by_type = {
    public  = [for k, v in module.subnets : v.subnet_id if var.subnets_list[index(var.subnets_list.*.cidr_block, k)].type == "public"]
    private = [for k, v in module.subnets : v.subnet_id if var.subnets_list[index(var.subnets_list.*.cidr_block, k)].type == "private"]
  }

  # Map CIDR blocks to subnet IDs
  subnet_id_map = {
    for k, v in module.subnets : k => v.subnet_id
  }

  # Generate association maps with index-based static keys
  public_subnet_associations_map = {
    for idx, subnet in var.subnets_list :
    "${subnet.type}-${idx}" => {
      subnet_id = local.subnet_id_map[subnet.cidr_block]
    } if subnet.type == "public"
  }

  private_subnet_associations_map = {
    for idx, subnet in var.subnets_list :
    "${subnet.type}-${idx}" => {
      subnet_id = local.subnet_id_map[subnet.cidr_block]
    } if subnet.type == "private"
  }

  route_table_list = [
    {
      type = "public"
      routes = [
        {
          cidr_block = "0.0.0.0/0"
          gateway_id = module.internet_gateway.internet_gateway_id
        }
      ]
    },
    {
      type = "private"
      routes = [
        {
          cidr_block     = "0.0.0.0/0"
          nat_gateway_id = module.nat_gateway.nat_gateway_id
        }
      ]
    }
  ]
}
