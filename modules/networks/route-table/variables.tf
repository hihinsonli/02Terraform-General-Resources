variable "vpc_id" {
  description = "(Required) The VPC ID."
  type        = string
}

variable "routes" {
  description = "(Optional) List of route objects for the route table"
  type        = any
  default     = []
}

variable "subnet_route_associations_map" {
  description = "(Optional) Map of subnet associations with static keys"
  type = map(object({
    subnet_id = string
  }))
  default = {}
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}
