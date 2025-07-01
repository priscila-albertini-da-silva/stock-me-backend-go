data "aws_iam_policy_document" "api_gateway_policy_doc" {
  statement {
    effect  = "Allow"
    actions = ["execute-api:Invoke"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${aws_api_gateway_rest_api.api_gateway.id}/${var.stage_name}/${var.create_storage_location_http_method}/${var.path_part}",
      "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${aws_api_gateway_rest_api.api_gateway.id}/${var.stage_name}/${var.update_storage_location_http_method}/${var.path_part}",
      "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${aws_api_gateway_rest_api.api_gateway.id}/${var.stage_name}/${var.find_storage_location_http_method}/${var.path_part}",
      "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${aws_api_gateway_rest_api.api_gateway.id}/${var.stage_name}/${var.remove_storage_location_http_method}/${var.path_part}"
    ]
  }
}
