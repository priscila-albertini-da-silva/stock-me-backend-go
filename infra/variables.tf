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
  default = "bootstrap"
}

variable "lambda_runtime" {
  default = "provided.al2"
}

variable "api_gateway_name" {
  default = "stock-me-storage-location-api"
}

variable "path_part" {
  type        = string
  description = "value for the path part of the API Gateway resource"
  default     = "storage-location"
}

variable "stage_name" {
  default = "prod"
}

variable "create_storage_location_http_method" {
  default = "POST"
}

variable "update_storage_location_http_method" {
  default = "PUT"
}

variable "find_storage_location_http_method" {
  default = "GET"
}

variable "remove_storage_location_http_method" {
  default = "DELETE"
}
