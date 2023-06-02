resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name        = "Daily-Trigger"
  description = "Trigger the EventBridge rule daily at 20:00 PM"

  schedule_expression = "cron(0 20 * * ? *)"
}

resource "aws_cloudwatch_event_target" "codebuild_target" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  target_id = "Code-Build-Target"
  arn       = aws_codebuild_project.your_codebuild_project.arn
}