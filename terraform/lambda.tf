variable "myregion" {
    default = "eu-central-1"
}

variable "accountId" {
    default = "904112984347"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "marathon_lambda" {
  filename      = "devops-marathon.zip"
  function_name = "tg-bot"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "tg-bot.lambda_handler"
  publish = true

  source_code_hash = filebase64sha256("devops-marathon.zip")

  runtime = "python3.6"

  environment {
    variables = {
      BOT_TOKEN = var.bottoken
      ADMINCHAT = var.adminchat
      GATEWAY = aws_instance.linux-instance.public_ip
      USERNAME = var.username
      PASSWORD = var.password
    }
  }
}

resource "aws_api_gateway_rest_api" "devops-marathon" {
  name        = "devops-marathon"
}

resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.devops-marathon.id
   parent_id   = aws_api_gateway_rest_api.devops-marathon.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
   rest_api_id   = aws_api_gateway_rest_api.devops-marathon.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
   rest_api_id = aws_api_gateway_rest_api.devops-marathon.id
   resource_id = aws_api_gateway_method.proxy.resource_id
   http_method = aws_api_gateway_method.proxy.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.marathon_lambda.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
   rest_api_id   = aws_api_gateway_rest_api.devops-marathon.id
   resource_id   = aws_api_gateway_rest_api.devops-marathon.root_resource_id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.devops-marathon.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.marathon_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "devops-marathon" {
   depends_on = [
     aws_api_gateway_integration.lambda,
     aws_api_gateway_integration.lambda_root,
   ]

   rest_api_id = aws_api_gateway_rest_api.devops-marathon.id
   stage_name  = "devops"
}

resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.marathon_lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.devops-marathon.execution_arn}/*/*"
}

