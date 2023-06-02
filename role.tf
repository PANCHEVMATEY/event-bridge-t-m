# create ssm-role and and add access to cloudwatch
resource "aws_iam_role" "ssm_selfmade" {
  name = "ssm-mgmt"
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

#ssm mgmt attachment -----------
resource "aws_iam_role_policy_attachment" "ssm_mgmt_attachment" {
  role       = aws_iam_role.ssm_selfmade.id
  policy_arn = var.policy_ssm
}

# iam instance profile
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "instance-profile"
  role = aws_iam_role.ssm_selfmade.name
  tags = {
    name = "profile"
  }
}