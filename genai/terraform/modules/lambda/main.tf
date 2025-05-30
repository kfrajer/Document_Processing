# Create Lambda function
resource "aws_lambda_function" "bedrock_trigger" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${var.project_name}-trigger-bedrock-lambda"
  role            = aws_iam_role.bedrock_trigger.arn
  handler         = "main.handler"
  runtime         = "python3.9"
  timeout         = 300
  memory_size     = 256
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      REGION          = var.aws_region
      PROCESSED_BUCKET = var.s3_bucket_processed_bucket
      RAW_BUCKET      = var.s3_bucket_raw_bucket
    }
  }
}

# Create zip file from Lambda source code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.root}/../src/functions/trigger_bedrock"
  output_path = "${path.root}/../build/trigger_bedrock.zip"
}

# change number of retries:
resource "aws_lambda_function_event_invoke_config" "trigger_bedrock_config" {
  function_name = aws_lambda_function.bedrock_trigger.function_name
  maximum_retry_attempts = 0
}


# Add SQS trigger for Lambda
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.bedrock_trigger.arn
  batch_size       = 1
  enabled          = true
  function_response_types = ["ReportBatchItemFailures"]
}