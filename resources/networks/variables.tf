variable "aws_region" {
  default     = "ap-southeast-2"
  description = "(Optional) AWS Region to be deployed."
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}

############## VPC ##############
variable "cidr_block" {
  description = "(Required) The IPv4 CIDR block for the VPC."
  type        = string
}

variable "instance_tenancy" {
  default     = "default"
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default"
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

############## Subnets ##############
variable "assign_ipv6_address_on_creation" {
  default     = false
  description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false."
  type        = bool
}

variable "subnets_list" {
  default     = null
  description = "(Optional) Subnets List to be created within the VPC."
  type = list(object({
    az         = string
    cidr_block = string
    type       = string
  }))
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

############## NAT Gateway ##############
variable "connectivity_type" {
  default     = "public"
  description = "(Optional) Connectivity type for the NAT Gateway. Valid values are private and public."
  type        = string
}

variable "private_ip" {
  default     = null
  description = "(Optional) The private IPv4 address to assign to the NAT Gateway. If you don't provide an address, a private IPv4 address will be automatically assigned."
  type        = string
}

############## Network ACL ##############
variable "nacl_list" {
  description = "(Optional) List of NACL configurations"
  type = list(object({
    name          = string
    ingress_rules = list(map(string))
    egress_rules  = list(map(string))
  }))
  default = []
}
