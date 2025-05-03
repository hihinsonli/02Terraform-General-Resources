variable "cidr_block" {
  description = "(Required) The IPv4 CIDR block for the VPC."
  type        = string
}

variable "instance_tenancy" {
  default     = "default"
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default"
  type        = string
}

variable "ipv6_cidr_block" {
  default     = null
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool."
  type        = string
}

variable "ipv6_ipam_pool_id" {
  default     = null
  description = "(Optional) IPAM Pool ID for a IPv6 pool. Conflicts with assign_generated_ipv6_cidr_block."
  type        = string
}

variable "enable_dns_support" {
  default     = true
  description = "(Optional) a VPC-level configuration that controls whether the VPC can use AWS-provided DNS."
  type        = bool
}

variable "enable_network_address_usage_metrics" {
  default     = false
  description = "(Optional) Indicates whether Network Address Usage metrics are enabled for your VPC."
  type        = bool
}

variable "enable_dns_hostnames" {
  default     = true
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
}

variable "assign_generated_ipv6_cidr_block" {
  default     = true
  description = "(Optional) You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false."
  type        = bool
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}
