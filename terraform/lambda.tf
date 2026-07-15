resource "aws_lambda_function" "counter" {

  filename = "${path.module}/lambda/function.zip"

  function_name = "visitor-counter-function"

  role = aws_iam_role.lambda_role.arn

  handler = "lambda_function.lambda_handler"

  runtime = "python3.12"

  source_code_hash = filebase64sha256(
    "${path.module}/lambda/function.zip"
  )
}