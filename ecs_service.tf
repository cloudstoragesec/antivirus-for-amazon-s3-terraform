resource "aws_ecs_cluster" "Cluster" {
  name = "${var.service_name}Cluster-${aws_appconfig_application.AppConfigAgentApplication.id}"
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleCluster" }
}

resource "aws_ecs_service" "Service" {
  name                               = "${var.service_name}ConsoleService-${aws_appconfig_application.AppConfigAgentApplication.id}"
  count                              = var.configure_load_balancer ? 0 : 1
  cluster                            = aws_ecs_cluster.Cluster.id
  task_definition                    = aws_ecs_task_definition.TaskDefinition.arn
  desired_count                      = 1
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  launch_type                        = "FARGATE"
  platform_version                   = var.ecs_platform_version
  network_configuration {
    subnets          = [var.subnet_a_id, var.subnet_b_id]
    security_groups  = [aws_security_group.ContainerSecurityGroup.id]
    assign_public_ip = var.ConsoleAutoAssignPublicIp
  }
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleService" }
}


resource "aws_ecs_service" "ServiceWithLB" {
  count                              = var.configure_load_balancer ? 1 : 0
  name                               = "${var.service_name}ConsoleService-${aws_appconfig_application.AppConfigAgentApplication.id}"
  cluster                            = aws_ecs_cluster.Cluster.id
  task_definition                    = aws_ecs_task_definition.TaskDefinition.arn
  desired_count                      = 1
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  launch_type                        = "FARGATE"
  platform_version                   = var.ecs_platform_version
  load_balancer {
    target_group_arn = aws_lb_target_group.TargetGroup[0].arn
    container_name   = "${var.service_name}Console-${aws_appconfig_application.AppConfigAgentApplication.id}"
    container_port   = 443
  }

  network_configuration {
    subnets          = [var.subnet_a_id, var.subnet_b_id]
    security_groups  = [aws_security_group.ContainerSecurityGroupWithLB.id]
    assign_public_ip = var.ConsoleAutoAssignPublicIp
  }
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleService" }
}

resource "aws_lb_target_group" "TargetGroup" {
  count    = var.configure_load_balancer ? 1 : 0
  name     = "${var.service_name}TG-LB-${aws_appconfig_application.AppConfigAgentApplication.id}"
  port     = var.tcp_port
  protocol = var.target_protocol
  health_check {
    protocol = var.target_protocol
    port     = var.hc_port
    path     = var.hc_path
    interval = var.hc_interval
    timeout  = var.hc_timeout
  }
  target_type          = "ip"
  vpc_id               = var.vpc
  deregistration_delay = 60
  tags                 = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleTargetGroup" }
}

resource "aws_lb_listener" "Listener" {
  count             = var.configure_load_balancer ? 1 : 0
  load_balancer_arn = aws_lb.LoadBalancer[0].arn
  port              = var.tcp_port
  protocol          = var.target_protocol
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-3-2021-06"
  certificate_arn   = var.lb_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TargetGroup[0].arn
  }
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleListener" }
}

resource "aws_lb" "LoadBalancer" {
  count              = var.configure_load_balancer ? 1 : 0
  name               = "${var.service_name}LB-${aws_appconfig_application.AppConfigAgentApplication.id}"
  idle_timeout       = 60
  internal           = var.lb_scheme != "internet-facing"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.LoadBalancerSecurityGroup.id]
  subnets            = [var.subnet_a_id, var.subnet_b_id]
  tags               = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleLoadBalancer" }
}

