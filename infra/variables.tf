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

variable "create_path_part" {
  default = "create_storage-location"
}

variable "update_path_part" {
  default = "update_storage-location"
}

variable "find_path_part" {
  default = "find_storage-location"
}

variable "remove_path_part" {
  default = "remove_storage-location"
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
