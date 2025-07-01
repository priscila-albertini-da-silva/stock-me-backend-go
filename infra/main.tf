terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "lambda" {
  source                    = "./modules/lambda"
  lambda_zip                = var.lambda_zip
  lambda_name               = var.lambda_name
  handler                   = var.lambda_handler
  runtime                   = var.lambda_runtime
  stage_name                = var.stage_name
  api_gateway_execution_arn = module.api_gateway.execution_arn
}

module "api_gateway" {
  source                              = "./modules/api-gateway"
  lambda_arn                          = module.lambda.lambda_arn
  lambda_name                         = module.lambda.lambda_name
  api_name                            = var.api_gateway_name
  path_part                           = var.path_part
  aws_region                          = var.aws_region
  stage_name                          = var.stage_name
  create_storage_location_http_method = var.create_storage_location_http_method
  update_storage_location_http_method = var.update_storage_location_http_method
  find_storage_location_http_method   = var.find_storage_location_http_method
  remove_storage_location_http_method = var.remove_storage_location_http_method
}
