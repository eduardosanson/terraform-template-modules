variable "lambda_packed_name"   {  default = "lambda_function.zip" }
variable "layer_packed_name"    {  default = "layer.zip"}
variable "layer_runtimes"       {  type = list(string) }
variable "lambda_file_path"     {}
variable "layer_dir"            {}
variable "lambda_function_name" {}
variable "layer_name"           {}
variable "lambda_runtime"       {}
variable "lambda_file_name"     {}
variable "lambda_handler_name"  {}
variable "lambda_role_arn"      {}
