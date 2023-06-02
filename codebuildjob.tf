resource "aws_codebuild_project" "nuke_project" {
  name                   = "nuke-project"
  description            = "CodeBuild project to nuke all resources"
  build_timeout          = 5
  service_role           = aws_iam_role.nuke_role.arn

  source {
    buildspec              = "buildspec.yml"
    type                   = "NO_SOURCE"
    }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type         = "LINUX_CONTAINER"
  }
}