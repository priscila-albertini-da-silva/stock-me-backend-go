resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.api_name
  description = "API Gateway for StockMe"
}

resource "aws_api_gateway_rest_api_policy" "api_gateway_policy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  policy      = data.aws_iam_policy_document.api_gateway_policy_doc.json
  depends_on  = [aws_api_gateway_rest_api.api_gateway, data.aws_iam_policy_document.api_gateway_policy_doc]
}

# [create_storage_location] API: METHOD, INTEGRATION
resource "aws_api_gateway_method" "api_gateway_method_create_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method   = var.create_storage_location_http_method
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_integration" "lambda_integration_create_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method             = var.create_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
  depends_on              = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_method.api_gateway_method_create_storage_location]
}

# [update_storage_location] API: METHOD, INTEGRATION
resource "aws_api_gateway_method" "api_gateway_method_update_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method   = var.update_storage_location_http_method
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_integration" "lambda_integration_update_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method             = var.update_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
  depends_on              = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_method.api_gateway_method_update_storage_location]
}

# [find_storage_location] API: METHOD, INTEGRATION
resource "aws_api_gateway_method" "api_gateway_method_find_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method   = var.find_storage_location_http_method
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_integration" "lambda_integration_find_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method             = var.find_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
  depends_on              = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_method.api_gateway_method_find_storage_location]
}

# [remove_storage_location] API: METHOD, INTEGRATION
resource "aws_api_gateway_method" "api_gateway_method_remove_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method   = var.remove_storage_location_http_method
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_integration" "lambda_integration_remove_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_rest_api.api_gateway.root_resource_id
  http_method             = var.remove_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
  depends_on              = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_method.api_gateway_method_remove_storage_location]
}

# DEPLOYMENT, STAGE and METHOD SETTINGS
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  # lifecycle {
  #   create_before_destroy = true
  # }
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.api_gateway.id,
      aws_api_gateway_integration.lambda_integration_create_storage_location,
      aws_api_gateway_integration.lambda_integration_update_storage_location,
      aws_api_gateway_integration.lambda_integration_find_storage_location,
      aws_api_gateway_integration.lambda_integration_remove_storage_location,
      data.aws_iam_policy_document.api_gateway_policy_doc.json,
      var.stage_name,
      var.create_storage_location_http_method,
      var.update_storage_location_http_method,
      var.find_storage_location_http_method,
      var.remove_storage_location_http_method,
      var.path_part,
    ]))
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_rest_api_policy.api_gateway_policy,
    aws_api_gateway_method.api_gateway_method_create_storage_location,
    aws_api_gateway_method.api_gateway_method_update_storage_location,
    aws_api_gateway_method.api_gateway_method_find_storage_location,
    aws_api_gateway_method.api_gateway_method_remove_storage_location,
    aws_api_gateway_integration.lambda_integration_create_storage_location,
    aws_api_gateway_integration.lambda_integration_update_storage_location,
    aws_api_gateway_integration.lambda_integration_find_storage_location,
    aws_api_gateway_integration.lambda_integration_remove_storage_location
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

