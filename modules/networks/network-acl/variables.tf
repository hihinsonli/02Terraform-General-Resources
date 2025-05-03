variable "vpc_id" {
  description = "(Required) The VPC ID."
  type        = string
}

variable "subnet_ids" {
  default     = []
  description = "(Optional) A list of Subnet IDs to apply the ACL to."
  type        = list(string)
}

variable "ingress_rules" {
  type    = any
  default = []
}

variable "egress_rules" {
  type    = any
  default = []
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}
