variable "load_balancer_arn"{type = string}
variable "vpc_id"           {type = string}
variable "target_group_name"{type = string}
variable "lb_port_redirect" {type = number}
variable "health_check_path" {default = ""}

variable "protocol" {
  type = string
  default = ""
}
