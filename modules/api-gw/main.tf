resource "aws_api_gateway_rest_api" "api" {
  name = var.application_name
  body = data.template_file.swagger.rendered

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

data "template_file" "swagger" {
  template = file(var.swagger_path)

  vars = {
    connectionId        = aws_api_gateway_vpc_link.vpc_link.id
    nlb_domain_name     = var.nlb_domain_name
    nlb_listener_port   = var.nlb_listener_port
    title               = var.application_name
  }
}

resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = "${var.application_name}-vpc-link"
  description = "link to nlb"
  target_arns = [var.lb_arn]

}

resource "aws_api_gateway_deployment" "test" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "default"
}