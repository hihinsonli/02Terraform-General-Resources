output "vpc_arn" {
  value       = aws_vpc.root.arn
  description = "Amazon Resource Name (ARN) of VPC."
}

output "vpc_id" {
  value       = aws_vpc.root.id
  description = "The ID of the VPC."
}

output "vpc_default_network_acl_id" {
  value       = aws_vpc.root.default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation."
}

output "vpc_main_route_table_id" {
  value       = aws_vpc.root.main_route_table_id
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association."
}

output "vpc_default_security_group_id" {
  value       = aws_vpc.root.default_security_group_id
  description = "The ID of the security group created by default on VPC creation."
}

output "vpc_default_route_table_id" {
  value       = aws_vpc.root.default_route_table_id
  description = "The ID of the route table created by default on VPC creation."
}

output "vpc_name" {
  value       = aws_vpc.root.tags_all.Name
  description = "Tags value with Name key"
}
