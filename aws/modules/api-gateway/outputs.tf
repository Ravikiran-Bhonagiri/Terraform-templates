output "api_gateway_invoke_url" {
  description = "Default API Gateway Invoke URL"
  value       = aws_api_gateway_deployment.example.invoke_url
}

output "api_gateway_custom_domain_url" {
  description = "Custom Domain URL for the API Gateway (if configured)"
  value       = var.domain_name != "" ? "https://${aws_api_gateway_domain_name.custom_domain[0].domain_name}" : "Custom Domain not configured"
}

output "api_gateway_execution_arn" {
  description = "ARN of the API Gateway REST API execution"
  value       = aws_api_gateway_rest_api.example.execution_arn
}

output "api_gateway_stage_name" {
  description = "Name of the API Gateway Stage"
  value       = aws_api_gateway_stage.example.stage_name
}
