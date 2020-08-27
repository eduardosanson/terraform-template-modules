output "lambda_function_name" {
  value = aws_lambda_function.test_lambda.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.test_lambda.arn
}