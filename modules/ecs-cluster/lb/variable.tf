variable "cluster_name" {type = string}
variable "sg_id"        {type = string}
variable "vpc_subnets"  {type = list(string)}
variable "lb-type"      {type = string}
variable "vpc_lik"      {type = bool}