resource "aws_sns_topic" "NotificationsTopic" {
  name = "${var.service_name}NotificationsTopic-${aws_appconfig_application.AppConfigAgentApplication.id}"
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleSnsTopic" }
}

resource "aws_sns_topic_policy" "NotificationsTopicPolicy" {
  arn    = aws_sns_topic.NotificationsTopic.arn
  policy = data.aws_iam_policy_document.TopicPolicyDocument.json
}

data "aws_iam_policy_document" "TopicPolicyDocument" {
  policy_id = "2012-10-17"

  statement {
    actions = ["sns:Publish"]
    effect  = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "${aws_iam_role.AgentTaskRole.arn}",
        "${aws_iam_role.ConsoleTaskRole.arn}"
      ]
    }

    resources = [
      aws_sns_topic.NotificationsTopic.arn
    ]

    sid = "2012-10-17"
  }
}
