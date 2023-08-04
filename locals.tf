locals {
  URL = "${var.configure_load_balancer}" ? "https://${aws_lb.LoadBalancer[0].dns_name}" : "https://${var.aws_account}-${aws_appconfig_application.AppConfigAgentApplication.id}.cloudstoragesecapp.com"
}
