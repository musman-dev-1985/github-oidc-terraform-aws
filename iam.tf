resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.lambda_function_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

data "aws_iam_policy_document" "s3_policy_doc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = [
      "${aws_s3_bucket.my_bucket.arn}/*",
      "${aws_s3_bucket.my_bucket.arn}",
    ]
  }
}

data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:UpdateFunctionCode",
      "lambda:GetFunction",
      "lambda:InvokeFunction",
    ]

    resources = [
      "arn:aws:lambda:${var.aws_region}:138726246787:function:${var.lambda_function_name}",
    ]
  }
}

resource "aws_iam_policy" "s3_policy" {
  name   = "${var.lambda_function_name}_s3_policy"
  policy = data.aws_iam_policy_document.s3_policy_doc.json
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.lambda_function_name}_lambda_policy"
  policy = data.aws_iam_policy_document.lambda_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
