resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  handler       = "index.handler"
  role          = aws_iam_role.lambda_exec_role.arn
  runtime       = "nodejs14.x"

  s3_bucket = aws_s3_bucket.my_bucket.bucket
  s3_key    = "lambda_function.zip"

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.my_bucket.bucket
    }
  }
}
