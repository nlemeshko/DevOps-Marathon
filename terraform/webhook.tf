resource "null_resource" "deleteWebhook" {
  provisioner "local-exec" {
    command = "curl https://api.telegram.org/bot$TOKEN/deleteWebHook"

    environment = {
      TOKEN = var.bottoken
    }
  }
}

resource "null_resource" "setWebhook" {
  provisioner "local-exec" {
    command = "curl https://api.telegram.org/bot$TOKEN/setWebhook?url=$GATEWAY"

    environment = {
      TOKEN = var.bottoken
      GATEWAY = aws_api_gateway_deployment.devops-marathon.invoke_url
    }
  }
  
  depends_on = [
     aws_api_gateway_integration.lambda,
     aws_api_gateway_integration.lambda_root,
   ]
}