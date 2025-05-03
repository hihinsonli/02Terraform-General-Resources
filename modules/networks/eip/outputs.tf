output "eip_allocation_id" {
  value       = aws_eip.root.allocation_id
  description = "ID that AWS assigns to represent the allocation of the Elastic IP address for use with instances in a VPC."
}

output "eip_association_id" {
  value       = aws_eip.root.association_id
  description = "ID representing the association of the address with an instance in a VPC."
}

output "eip_id" {
  value       = aws_eip.root.id
  description = "Contains the EIP allocation ID."
}

output "eip_name" {
  value       = aws_eip.root.tags_all.Name
  description = "Tags value with Name key"
}

output "eip_private_dns" {
  value       = aws_eip.root.private_dns
  description = "The Private DNS associated with the Elastic IP address (if in VPC)."
}

output "eip_private_ip" {
  value       = aws_eip.root.private_ip
  description = "Contains the private IP address (if in VPC)."
}

output "eip_public_dns" {
  value       = aws_eip.root.public_dns
  description = "Public DNS associated with the Elastic IP address."
}

output "eip_public_ip" {
  value       = aws_eip.root.public_ip
  description = "Contains the public IP address."
}
