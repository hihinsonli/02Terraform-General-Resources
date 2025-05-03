locals {
  valid_border_group = contains(["us-east-1", "us-west-2", "ap-southeast-2"], var.network_border_group) ? var.network_border_group : "ap-southeast-2"
}
