variable "associate_with_private_ip" {
  default     = null
  description = "(Optional) User-specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address."
  type        = string
}

variable "domain" {
  default     = "vpc"
  description = "(Optional) Indicates if this EIP is for use in VPC (vpc)."
  type        = string
}

variable "instance" {
  default     = null
  description = "(Optional) EC2 instance ID."
  type        = string
}

variable "network_border_group" {
  default     = ""
  description = "(Optional) Location from which the IP address is advertised. Use this parameter to limit the address to this location."
  type        = string
}

variable "network_interface" {
  default     = null
  description = "(Optional) Network interface ID to associate with."
  type        = string
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}
