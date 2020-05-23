variable "load_balancer_arn" {}
variable "lb_port_redirect" {type = number}
variable "vpc_id" {}
variable "container_name" {}
variable "health_check_path" {}
variable "protocol" { default = ""}