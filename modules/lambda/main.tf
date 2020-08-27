resource "aws_lambda_layer_version" "lambda_layer" {
  filename            = data.archive_file.layer_zip.output_path
  layer_name          = var.layer_name
  source_code_hash    = data.archive_file.layer_zip.output_base64sha256
  compatible_runtimes = var.layer_runtimes
}

resource "aws_lambda_function" "test_lambda" {
  filename         = var.lambda_packed_name
  function_name    = var.lambda_function_name
  role             = var.lambda_role_arn
  handler          = "${var.lambda_file_name}.${var.lambda_handler_name}"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = var.lambda_runtime
  layers           = [aws_lambda_layer_version.lambda_layer.arn]
  timeout          = 10
}

