resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.api_name
  description = "API Gateway for StockMe"
}

resource "aws_api_gateway_rest_api_policy" "api_gateway_policy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  policy      = data.aws_iam_policy_document.api_gateway_policy_doc.json
  depends_on  = [aws_api_gateway_rest_api.api_gateway, data.aws_iam_policy_document.api_gateway_policy_doc]
}

resource "aws_api_gateway_method" "api_gateway_methods" {
  for_each      = toset(local.methods)
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method   = each.key
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_integration" "lambda_integration" {
  for_each                = toset(local.methods)
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method             = each.key
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
  depends_on              = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_method.api_gateway_methods]
}

resource "aws_api_gateway_deployment" "deployment" {
  for_each    = toset(local.methods)
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(jsondecode([
      data.aws_iam_policy_document.api_gateway_policy_doc.json,
      var.stage_name,
      each.key,
      var.lambda_arn
    ]))
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_rest_api_policy.api_gateway_policy,
    aws_api_gateway_method.api_gateway_methods,
    aws_api_gateway_integration.lambda_integration
  ]
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  deployment_id = aws_api_gateway_deployment.deployment.id

  depends_on = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_deployment.deployment]
}

resource "aws_api_gateway_method_settings" "api_gateway_method_settings" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = aws_api_gateway_stage.api_gateway_stage.stage_name
  method_path = "/*"
  settings {
    metrics_enabled    = true
    logging_level      = "INFO"
    data_trace_enabled = true
  }

  depends_on = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_stage.api_gateway_stage]
}

