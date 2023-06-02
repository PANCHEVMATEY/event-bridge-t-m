resource "aws_iam_policy_attachment" "nuke_policy_attachment" {
  name       = "nuke-policy-attachment"
  roles      = [aws_iam_role.nuke_role.name]
  policy_arn = var.policy_arn_Admin_Access
}