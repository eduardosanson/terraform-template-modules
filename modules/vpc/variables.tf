variable "cidr_vpc" {
  description = "CIDR blovk for the VPC"
  default = "10.1.0.0/16"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "production"
}
