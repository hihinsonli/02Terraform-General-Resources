module "eip" {
  source = "../../modules/networks/eip"
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
