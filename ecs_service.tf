resource "aws_ecs_cluster" "Cluster" {
  name = "${var.service_name}Cluster-${aws_appconfig_application.AppConfigAgentApplication.id}"
  tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleCluster"}
  
}

resource "aws_ecs_service" "Service" {
  name                       = "${var.service_name}ConsoleService-${aws_appconfig_application.AppConfigAgentApplication.id}"
  count                      = var.configure_load_balancer ? 0 : 1 # Condition: DontUseLB
  cluster                    = aws_ecs_cluster.Cluster.id
  task_definition            = aws_ecs_task_definition.TaskDefinition.arn
  desired_count              = 1
  deployment_maximum_percent = var.deployment_maximum_percent 
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent 
  launch_type                = "FARGATE"
  platform_version           = var.ecs_platform_version
  network_configuration {
    subnets = [var.subnet_a_id,var.subnet_b_id]
    security_groups = [aws_security_group.ContainerSecurityGroup.id]
    assign_public_ip = "${var.ConsoleAutoAssignPublicIp}"
  }
  tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleService"}
}



resource "aws_ecs_service" "ServiceWithLB" {
  count = var.configure_load_balancer ? 1 : 0 # Condition: UseLB
  name            = "${var.service_name}ConsoleService-${aws_appconfig_application.AppConfigAgentApplication.id}"
  cluster         = aws_ecs_cluster.Cluster.id
  task_definition = aws_ecs_task_definition.TaskDefinition.arn
  desired_count   = 1
  deployment_maximum_percent = var.deployment_maximum_percent 
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent 
  launch_type                = "FARGATE"
  platform_version           = var.ecs_platform_version
  load_balancer {
    target_group_arn = "${aws_lb_target_group.TargetGroup[0].arn}"
    container_name   = "${var.service_name}Console-${aws_appconfig_application.AppConfigAgentApplication.id}"
    container_port   = 443
  }

  network_configuration {
    subnets = [var.subnet_a_id,var.subnet_b_id]
    security_groups = [aws_security_group.ContainerSecurityGroupWithLB.id]
    assign_public_ip = "${var.ConsoleAutoAssignPublicIp}"
  }
  tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleService"}
  
}

resource "aws_lb_target_group" "TargetGroup" {
  count = var.configure_load_balancer ? 1 : 0 # Condition: UseLB
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
  target_type = "ip"
  vpc_id      = "${var.vpc}"
  deregistration_delay  = 60 # default is 300
  tags        = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleTargetGroup"}
  
}

resource "aws_lb_listener" "Listener" {
  count = var.configure_load_balancer ? 1 : 0 # Condition: UseLB
  load_balancer_arn = aws_lb.LoadBalancer[0].arn
  port              = var.tcp_port
  protocol          = var.target_protocol
  #Please mark these are hardcoded #Pending, does this need to parameterized, needs as required variable only if using load balancer
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "arn:aws:acm:us-east-1:044296141156:certificate/dddd5c35-84fb-4591-870f-8a08e01e5a50"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.TargetGroup[0].arn}"
  }
  tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleListener"}
  
}

resource "aws_lb" "LoadBalancer" {
  count = var.configure_load_balancer ? 1 : 0 # Condition: UseLB
  name               = "${var.service_name}LB-${aws_appconfig_application.AppConfigAgentApplication.id}"
  idle_timeout  = 60
  #please mark scheme= internet facing and internal is done below way where it sayd internal is false, please confirm what is correct here #Pending, add variable as internal load balancer
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.LoadBalancerSecurityGroup.id]
  subnets = [var.subnet_a_id,var.subnet_b_id]
  tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleLoadBalancer"}
  

}

