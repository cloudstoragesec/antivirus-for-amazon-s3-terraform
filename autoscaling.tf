resource "aws_appautoscaling_target" "AutoScalingTarget" {
  count                      = var.configure_load_balancer ? 0 : 1 # Condition: DontUseLB
  max_capacity       = 1
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.Cluster.name}/${aws_ecs_service.Service[0].name}"
  role_arn = "arn:aws:iam::${var.aws_account}:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleAutoScaling"}
}

resource "aws_appautoscaling_target" "AutoScalingTargetWithLb" {
  count = var.configure_load_balancer ? 1 : 0 # Condition: UseLB
  max_capacity       = 1
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.Cluster.name}/${aws_ecs_service.ServiceWithLB[0].name}"
  role_arn = "arn:aws:iam::${var.aws_account}:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleAutoScaling"}
}