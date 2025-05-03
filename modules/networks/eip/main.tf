# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "root" {
  associate_with_private_ip = var.associate_with_private_ip
  domain                    = var.domain
  instance                  = var.instance
  network_border_group      = local.valid_border_group
  network_interface         = var.network_interface
  public_ipv4_pool          = "amazon"
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-eip"
    }
  )
}
