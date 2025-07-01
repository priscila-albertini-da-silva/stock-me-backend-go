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
  source      = "./modules/lambda"
  lambda_zip  = var.lambda_zip
  lambda_name = var.lambda_name
  handler     = var.lambda_handler
  runtime     = var.lambda_runtime
}

module "api-gateway" {
  source      = "./modules/api-gateway"
  lambda_arn  = module.lambda.lambda_arn
  lambda_name = module.lambda.lambda_name
  api_name    = var.api_gateway_name
  path_part   = var.path_part
  aws_region  = var.aws_region
}
