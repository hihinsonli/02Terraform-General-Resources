variable "vpc_id" {
  description = "(Required) The VPC ID."
  type        = string
}

variable "tags" {
  default     = {}
  description = "(Optional) A map of resources tags."
  type        = map(string)
}
