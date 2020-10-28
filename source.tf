data "aws_iam_policy_document" "lambda_execution_role_trust_relationship_document" {
  statement {
    sid = "1"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "lambda_execution_role_policy_document" {

  statement {
    sid = "1"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.sink.account_id}:role/assume-lambda-role"
    ]
    effect = "Allow"
  }

  statement {
    sid = "2"
    actions = [
      "logs:*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    sid = "3"
    actions = [
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:DescribeStream",
      "kinesis:ListStreams"
    ]
    resources = [
      "arn:aws:kinesis:us-east-1:${data.aws_caller_identity.source.account_id}:stream/*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_execution_role_trust_relationship_document.json
}

resource "aws_iam_role_policy" "lambda_execution_role_policy" {
  policy = data.aws_iam_policy_document.lambda_execution_role_policy_document.json
  role   = aws_iam_role.lambda_execution_role.id
}
