data "aws_iam_policy_document" "assume_lambda_role_trust_relationship_document" {
  statement {
    sid = "1"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.source.account_id}:role/${var.service_name}-lambda-execution-role"]
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "assume_lambda_policy_document" {
  statement {
    sid = "1"
    actions = [
      "kinesis:DescribeStream",
      "kinesis:ListStreams",
      "kinesis:PutRecord",
      "kinesis:PutRecords"
    ]
    resources = [
      "arn:aws:kinesis:us-east-1:${data.aws_caller_identity.sink.account_id}:stream/*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role" "assume_lambda_role" {
  provider           = aws.sink
  name               = "${var.service_name}-assume-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_role_trust_relationship_document.json
}

resource "aws_iam_role_policy" "assume_lambda_policy" {
  provider = aws.sink
  policy   = data.aws_iam_policy_document.assume_lambda_policy_document.json
  role     = aws_iam_role.assume_lambda_role.id
}
