output "subnet_arn" {
  value       = aws_subnet.root.arn
  description = "The ARN of the subnet."
}

output "subnet_id" {
  value       = aws_subnet.root.id
  description = "The ID of the subnet."
}

output "subnet_name" {
  value       = aws_subnet.root.tags_all.Name
  description = "Tags value with Name key"
}
