data "aws_iam_policy_document" "api_gateway_policy_doc" {
  statement {
    actions = ["execute-api:Invoke"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "execute-api:/${var.stage_name}/${var.create_storage_location_http_method}/${var.path_part}/",
      "execute-api:/${var.stage_name}/${var.update_storage_location_http_method}/${var.path_part}/",
      "execute-api:/${var.stage_name}/${var.find_storage_location_http_method}/${var.path_part}/",
      "execute-api:/${var.stage_name}/${var.remove_storage_location_http_method}/${var.path_part}/"
    ]
  }
}
