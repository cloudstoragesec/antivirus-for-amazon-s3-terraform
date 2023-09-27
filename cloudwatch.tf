resource "aws_cloudwatch_log_group" "cloudwatch_logs_group" {
  name              = "${var.service_name}.ECS.${aws_appconfig_application.AppConfigAgentApplication.id}.Console"
  tags              = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleTargetGroup" }
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "health_check_console_alarm" {
  alarm_name          = "${var.service_name}HealthCheck-Alarm-${aws_appconfig_application.AppConfigAgentApplication.id}"
  alarm_description   = "Alarm triggered if there is no data in the last 5 minutes"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 3
  metric_name         = "ConsoleStatus"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Sum"
  treat_missing_data  = "breaching"
  dimensions = {
    ClusterName = aws_ecs_cluster.Cluster.name,
    ServiceName = local.ecs_service_name,
    Version     = var.image_version_console
  }

  alarm_actions = [
    aws_sns_topic.NotificationsTopic.id
  ]
  insufficient_data_actions = [
    aws_sns_topic.NotificationsTopic.id
  ]
  ok_actions = [
    aws_sns_topic.NotificationsTopic.id
  ]
}
