resource "aws_iam_role" "lambda_role" {
  name               = "role_lambda_${var.name}"
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "lambda_xray_daemon" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_invoke_dynamodb" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaInvocation-DynamoDB"
}

resource "aws_iam_role_policy_attachment" "lambda_execute_dynamodb" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

