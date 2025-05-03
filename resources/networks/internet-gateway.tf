module "internet_gateway" {
  source = "../../modules/networks/internet-gateway"
  vpc_id = module.vpc.vpc_id
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}"
    }
  )
  depends_on = [
    module.vpc
  ]
}
