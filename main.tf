data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "lambda.zip"
}

data "aws_caller_identity" "source" {}

data "aws_caller_identity" "sink" {
  provider = aws.sink
}

resource "aws_lambda_function" "sync_lambda" {
  function_name    = "kinesis-cross-account-sync-lambda"
  handler          = "index.handler"
  filename         = "lambda.zip"
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "nodejs12.x"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      KINESIS_ASSUMED_ROLE = aws_iam_role.assume_lambda_role.arn,
      STREAMS              = var.sink_streams
    }
  }
}

data "aws_kinesis_stream" "source" {
  name = var.source_stream
}

resource "aws_lambda_event_source_mapping" "kinesis_lambda_event_mapping" {
  batch_size        = 100
  event_source_arn  = data.aws_kinesis_stream.source.arn
  enabled           = true
  function_name     = aws_lambda_function.sync_lambda.arn
  starting_position = "TRIM_HORIZON"
}
