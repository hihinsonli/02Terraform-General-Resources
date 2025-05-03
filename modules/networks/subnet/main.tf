# AWS Subnet: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "root" {
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  availability_zone               = var.availability_zone
  cidr_block                      = var.cidr_block
  enable_dns64                    = var.enable_dns64
  ipv6_cidr_block                 = var.ipv6_cidr_block
  ipv6_native                     = var.ipv6_native
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  vpc_id                          = var.vpc_id
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-subnet"
    }
  )
}
