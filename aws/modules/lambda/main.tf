resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout

  filename         = var.source_path
  source_code_hash = filebase64sha256(var.source_path)

  role = aws_iam_role.lambda_exec.arn

  environment {
    variables = var.environment_variables
  }

  layers = var.layers

  reserved_concurrent_executions = var.reserved_concurrent_executions

  publish = var.publish

  tags = var.tags
}
