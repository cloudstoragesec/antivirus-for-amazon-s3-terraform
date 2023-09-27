locals {
  console_image_url = "${var.ecr_account}.dkr.ecr.${var.aws_region}.amazonaws.com/cloudstoragesecurity/console:${var.image_version_console}"
  agent_image_url   = "${var.ecr_account}.dkr.ecr.${var.aws_region}.amazonaws.com/cloudstoragesecurity/agent:${var.image_version_agent}"

  URL = "${var.configure_load_balancer}" ? "https://${aws_lb.LoadBalancer[0].dns_name}" : "https://${var.aws_account}-${aws_appconfig_application.AppConfigAgentApplication.id}.cloudstoragesecapp.com"

  blanket_kms_access       = var.allow_access_to_all_kms_keys == "Yes"
  create_event_bridge_role = var.event_bridge_role_name == "Created by TF"
  use_proxy                = var.proxy_host != "none"
  is_antivirus             = var.product_mode == "AV"


  ecs_service_name = var.configure_load_balancer ? aws_ecs_service.ServiceWithLB[0].name : aws_ecs_service.Service[0].name
}
