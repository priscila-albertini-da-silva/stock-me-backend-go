variable "lambda_arn" {}
variable "lambda_name" {}
variable "api_name" {}
variable "path_part" {
  type        = string
  description = "value for the path part of the API Gateway resource"
}
