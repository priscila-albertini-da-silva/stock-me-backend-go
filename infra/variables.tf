variable "aws_region" {
  default = "sa-east-1"
}

variable "lambda_zip" {
  default = "lambda.zip"
}

variable "lambda_name" {
  default = "stock-me-storage-location-api-lambda"
}

variable "lambda_handler" {
  default = "main"
}

variable "lambda_runtime" {
  default = "go1.x"
}

variable "api_gateway_name" {
  default = "stock-me-storage-location-api"
}

variable "path_part" {
  type        = string
  description = "value for the path part of the API Gateway resource"
  default     = "storage-location"
}
