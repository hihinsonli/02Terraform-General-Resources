variable "allocation_id" {
  description = "(Required) The Allocation ID of the Elastic IP address for the NAT Gateway. Required for connectivity_type of public."
  type        = string
}

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

variable "subnet_id" {
  description = "(Required) The Subnet ID of the subnet in which to place the NAT Gateway."
  type        = string
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}
