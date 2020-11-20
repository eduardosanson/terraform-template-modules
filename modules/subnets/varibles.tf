variable "public_cidrs"    {type = list(string)}
variable "private_cidrs"   {type = list(string)}
variable "azs"             {type = list(string)}
variable "subnets_prefix"  {type = string}
variable "region"          {type = string}
variable "enable_nat"      {type = bool}
variable "environment_tag" {}
variable "vpc_id"          {}
variable "igw_id"          {}