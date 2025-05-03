# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl
resource "aws_network_acl" "root" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids != null ? var.subnet_ids : []

  dynamic "ingress" {
    for_each = var.ingress_rules != null ? var.ingress_rules : null
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      rule_no         = ingress.value.rule_no
      action          = ingress.value.action
      protocol        = ingress.value.protocol
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      icmp_code       = lookup(ingress.value, "icmp_code", null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules != null ? var.egress_rules : null
    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      rule_no         = egress.value.rule_no
      action          = egress.value.action
      protocol        = egress.value.protocol
      cidr_block      = lookup(egress.value, "cidr_block", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      icmp_code       = lookup(egress.value, "icmp_code", null)
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-network-acl"
    }
  )
}