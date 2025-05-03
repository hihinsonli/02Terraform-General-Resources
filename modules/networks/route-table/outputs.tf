output "route_table_arn" {
  value       = aws_route_table.root.arn
  description = "The ARN of the subnet."
}

output "route_table_id" {
  value       = aws_route_table.root.id
  description = "The ID of the subnet."
}

output "route_table_name" {
  value       = aws_route_table.root.tags_all.Name
  description = "Tags value with Name key"
}
