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
resource "aws_api_gateway_resource" "api_gateway_resource_create_storage_location" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = var.path_part

  depends_on = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_method" "api_gateway_method_create_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource_create_storage_location.id
  http_method   = var.create_storage_location_http_method
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_resource.api_gateway_resource_create_storage_location]
}

resource "aws_api_gateway_integration" "lambda_integration_create_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource_create_storage_location.id
  http_method             = var.create_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_method.api_gateway_method_create_storage_location,
    aws_api_gateway_resource.api_gateway_resource_create_storage_location
  ]
}

# [update_storage_location] API: METHOD, INTEGRATION
resource "aws_api_gateway_resource" "api_gateway_resource_update_storage_location" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.api_gateway_resource_create_storage_location.id
  path_part   = var.path_part

  depends_on = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_method" "api_gateway_method_update_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource_update_storage_location.id
  http_method   = var.update_storage_location_http_method
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.api_gateway, aws_api_gateway_resource.api_gateway_resource_update_storage_location]
}

resource "aws_api_gateway_integration" "lambda_integration_update_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource_update_storage_location.id
  http_method             = var.update_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_method.api_gateway_method_update_storage_location,
    aws_api_gateway_resource.api_gateway_resource_update_storage_location
  ]
}

# [find_storage_location] API: METHOD, INTEGRATION
resource "aws_api_gateway_resource" "api_gateway_resource_find_storage_location" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = var.path_part

  depends_on = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_method" "api_gateway_method_find_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource_find_storage_location.id
  http_method   = var.find_storage_location_http_method
  authorization = "NONE"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource_find_storage_location
  ]
}

resource "aws_api_gateway_integration" "lambda_integration_find_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource_find_storage_location.id
  http_method             = var.find_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_method.api_gateway_method_find_storage_location,
    aws_api_gateway_resource.api_gateway_resource_find_storage_location
  ]
}

# [remove_storage_location] API: METHOD, INTEGRATION
resource "aws_api_gateway_resource" "api_gateway_resource_remove_storage_location" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = var.path_part

  depends_on = [aws_api_gateway_rest_api.api_gateway]
}

resource "aws_api_gateway_method" "api_gateway_method_remove_storage_location" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource_remove_storage_location.id
  http_method   = var.remove_storage_location_http_method
  authorization = "NONE"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_resource.api_gateway_resource_remove_storage_location
  ]
}

resource "aws_api_gateway_integration" "lambda_integration_remove_storage_location" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource_remove_storage_location.id
  http_method             = var.remove_storage_location_http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_method.api_gateway_method_remove_storage_location,
    aws_api_gateway_resource.api_gateway_resource_remove_storage_location
  ]
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

  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_deployment.deployment,
    aws_api_gateway_account.account
  ]
}

resource "aws_api_gateway_method_settings" "api_gateway_method_settings" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = aws_api_gateway_stage.api_gateway_stage.stage_name
  method_path = "*/*"
  settings {
    metrics_enabled    = true
    logging_level      = "INFO"
    data_trace_enabled = true
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway,
    aws_api_gateway_stage.api_gateway_stage,
    aws_api_gateway_account.account
  ]
}

resource "aws_iam_role" "apigateway_cloudwatch" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "apigateway_cloudwatch_logs" {
  role       = aws_iam_role.apigateway_cloudwatch.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = aws_iam_role.apigateway_cloudwatch.arn
}
