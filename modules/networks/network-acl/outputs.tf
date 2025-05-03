output "network_acl_arn" {
  value       = aws_network_acl.root.arn
  description = "The ARN of the network ACL."
}

output "network_acl_id" {
  value       = aws_network_acl.root.id
  description = "The ID of the network ACL."
}

output "network_acl_name" {
  value       = aws_network_acl.root.tags_all.Name
  description = "Tags value with Name key"
}
