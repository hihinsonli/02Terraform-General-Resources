output "nat_gateway_id" {
  value       = aws_nat_gateway.root.id
  description = "The ID of the NAT Gateway."
}

output "nat_gateway_allocation_id" {
  value       = aws_nat_gateway.root.allocation_id
  description = "The association ID of the Elastic IP address that's associated with the NAT Gateway. Only available when connectivity_type is public."
}

output "nat_gateway_interface_id" {
  value       = aws_nat_gateway.root.network_interface_id
  description = "The ID of the network interface associated with the NAT Gateway."
}

output "nat_gateway_public_ip" {
  value       = aws_nat_gateway.root.public_ip
  description = "The Elastic IP address associated with the NAT Gateway."
}

output "nat_gateway_name" {
  value       = aws_nat_gateway.root.tags_all.Name
  description = "Tags value with Name key"
}
