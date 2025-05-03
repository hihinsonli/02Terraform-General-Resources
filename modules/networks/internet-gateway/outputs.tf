output "internet_gateway_arn" {
  value       = aws_internet_gateway.root.arn
  description = "The ARN of the Internet Gateway."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.root.id
  description = "The ID of the Internet Gateway."
}

output "internet_gateway_name" {
  value       = aws_internet_gateway.root.tags_all.Name
  description = "Tags value with Name key"
}
