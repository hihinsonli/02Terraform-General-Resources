variable "assign_ipv6_address_on_creation" {
  default     = false
  description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false."
  type        = bool
}

variable "availability_zone" {
  description = "(Required) AZ for the subnet."
  type        = string
}

variable "cidr_block" {
  description = "(Required) The IPv4 CIDR block for the subnet."
  type        = string
}

variable "enable_dns64" {
  default     = false
  description = "(Optional) Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. Default: false."
  type        = bool
}

variable "ipv6_cidr_block" {
  default     = null
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool."
  type        = string
}

variable "ipv6_native" {
  default     = false
  description = "(Optional) Indicates whether to create an IPv6-only subnet. Default: false."
  type        = bool
}

variable "map_public_ip_on_launch" {
  default     = false
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  type        = bool
}

variable "vpc_id" {
  description = "(Required) The VPC ID."
  type        = string
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}
