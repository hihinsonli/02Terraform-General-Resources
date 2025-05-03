# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "root" {
  connectivity_type = var.connectivity_type
  private_ip        = var.private_ip
  subnet_id         = var.subnet_id

  # Only set allocation_id if connectivity_type is "public"
  allocation_id = var.connectivity_type == "public" ? var.allocation_id : null

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-nat-gateway"
    }
  )
}
