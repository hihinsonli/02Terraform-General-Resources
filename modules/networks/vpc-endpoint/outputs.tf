output "vpc_endpoint_id" {
  description = "The ID of the VPC Endpoint."
  value       = aws_vpc_endpoint.root.id
}

output "vpc_endpoint_arn" {
  description = "The ARN of the VPC Endpoint."
  value       = aws_vpc_endpoint.root.arn
}

output "vpc_endpoint_dns_entry" {
  description = "The DNS entries for the VPC endpoint."
  value       = aws_vpc_endpoint.root.dns_entry
}

output "vpc_endpoint_name" {
  value       = aws_vpc_endpoint.root.tags_all.Name
  description = "Tags value with Name key"
}
