variable "vpc_id" {
  type        = string
  description = "(Required) The ID of the VPC in which the endpoint will be used."
}

variable "vpc_endpoint_type" {
  type        = string
  description = "(Optional) The VPC endpoint type. Valid values: Gateway, GatewayLoadBalancer, Interface, Resource, or ServiceNetwork."
  default     = "Gateway"
}

variable "service_name" {
  type        = string
  description = "(Optional) The service name to connect the endpoint to."
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "(Optional) The IDs of subnets to associate with the endpoint."
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Optional) List of security group IDs to associate with the endpoint."
  default     = []
}

variable "route_table_ids" {
  type        = list(string)
  description = "(Optional) List of route table IDs. Required for Gateway endpoints."
  default     = []
}

variable "auto_accept" {
  type        = bool
  description = "(Optional) Whether to auto-accept the VPC endpoint."
  default     = false
}

variable "policy" {
  type        = string
  description = "(Optional) Policy JSON to attach to the endpoint."
  default     = null
}

variable "private_dns_enabled" {
  type        = bool
  description = "(Optional) Whether to associate a private hosted zone with the endpoint."
  default     = true
}

variable "ip_address_type" {
  type        = string
  description = "(Optional) The IP address type for the endpoint. Valid values: ipv4, dualstack, ipv6."
  default     = null
}

variable "service_region" {
  type        = string
  description = "(Optional) The AWS region of the VPC Endpoint Service. Applicable for endpoints of type Interface."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the endpoint."
  default     = {}
}

variable "dns_options" {
  type = object({
    dns_record_ip_type                             = string
    private_dns_only_for_inbound_resolver_endpoint = optional(bool)
  })
  default     = null
  description = "(Optional) DNS options block"
}

variable "subnet_configuration" {
  type = object({
    subnet_id = string
    ipv4      = optional(string)
    ipv6      = optional(string)
  })
  default     = null
  description = "(Optional) Subnet configuration block for the endpoint"
}

variable "resource_configuration_arn" {
  type        = string
  description = "(Optional) The ARN of a Resource Configuration."
  default     = null
}

variable "service_network_arn" {
  type        = string
  description = "(Optional) The ARN of a Service Network."
  default     = null
}
