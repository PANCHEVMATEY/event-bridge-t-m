resource "aws_iam_role" "ssm_selfmade" {
  name = "Admin"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    name = "role"
  }
}

resource "aws_iam_role_policy_attachment" "Admin_Access" {
  role       = aws_iam_role.ssm_selfmade.id
  policy_arn = var.policy_arn_Admin_Access
}


resource "aws_iam_policy" "eventbridge_codebuild_policy" {
  name        = "Event-Bridge-Code-Build-Policy"
  description = "Policy to allow EventBridge to start CodeBuild"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowEventBridgeToStartCodeBuild",
      "Effect": "Allow",
      "Action": "codebuild:StartBuild",
      "Resource": "${aws_codebuild_project.your_codebuild_project.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eventbridge_codebuild_attachment" {
  role       = aws_iam_role.ssm_selfmade.name
  policy_arn = aws_iam_policy.eventbridge_codebuild_policy.arn
}

resource "aws_codebuild_project" "your_codebuild_project" {
  # Your CodeBuild project configuration goes here
  # ...
  service_role = aws_iam_role.ssm_selfmade.arn
}