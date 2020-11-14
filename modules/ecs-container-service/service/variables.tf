variable "role_execution_arn"   {type = string}
variable "role_service_arn"     {type = string}
variable "cluster_name"         {type = string}
variable "container_image"      {type = string}
variable "ecs_cluster_id"       {type = string}
variable "container_name"       {type = string}
variable "lb_port_redirect"     {type = number}
variable "lb_target_group_arn"  {type = list(string)}
variable "task_defination_path" {type = string}
