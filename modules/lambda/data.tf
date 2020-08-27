data "archive_file" "lambda_zip" {
  type          = "zip"
  source_file   = var.lambda_file_path
  output_path   = var.lambda_packed_name
}

data "archive_file" "layer_zip" {
  type          = "zip"
  source_dir   = var.layer_dir
  output_path   = var.layer_packed_name
}