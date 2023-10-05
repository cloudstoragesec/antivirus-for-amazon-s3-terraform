resource "aws_ecs_task_definition" "TaskDefinition" {
  family                   = "${var.service_name}Console-${aws_appconfig_application.AppConfigAgentApplication.id}"
  network_mode             = var.task_network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ExecutionRole.arn
  task_role_arn            = aws_iam_role.ConsoleTaskRole.arn
  container_definitions = jsonencode([
    {
      name                   = "${var.service_name}Console-${aws_appconfig_application.AppConfigAgentApplication.id}"
      image                  = "${local.console_image_url}"
      cpu                    = 512
      memoryReservation      = 1024
      readonlyRootFilesystem = true
      "environment" : [
        { "name" : "IMAGE_VERSION_CONSOLE", "value" : var.image_version_console },
        { "name" : "IMAGE_VERSION_AGENT", "value" : var.image_version_agent },
        { "name" : "AGENT_TASK_DEFINITION_ROLE_ARN", "value" : aws_iam_role.AgentTaskRole.arn },
        { "name" : "APP_CONFIG_AGENT_APPLICATION_ID", "value" : aws_appconfig_application.AppConfigAgentApplication.id },
        { "name" : "APP_CONFIG_AGENT_CONFIGURATION_PROFILE_ROLE_ARN", "value" : aws_iam_role.AppConfigAgentConfigurationDocumentRole.arn },
        { "name" : "APP_CONFIG_AGENT_DEPLOYMENT_STRATEGY_ID", "value" : aws_appconfig_deployment_strategy.AppConfigAgentDeploymentStrategy.id },
        { "name" : "APP_CONFIG_AGENT_ENVIRONMENT_ID", "value" : aws_appconfig_environment.AppConfigAgentEnvironment.environment_id },
        { "name" : "EXECUTION_ROLE_ARN", "value" : aws_iam_role.ExecutionRole.arn },
        { "name" : "EC2_CONTAINER_ROLE_ARN", "value" : aws_iam_instance_profile.Ec2ContainerInstanceProfile.arn },
        { "name" : "CONSOLE_VPC", "value" : var.vpc },
        { "name" : "CONSOLE_SUBNET", "value" : "${var.subnet_a_id},${var.subnet_b_id}" },
        { "name" : "PARAMETER_STORE_NAME_PREFIX", "value" : "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "CONSOLE_SECURITY_GROUP_ID", "value" : "${var.configure_load_balancer}" ? "${aws_security_group.ContainerSecurityGroupWithLB[0].id}" : "${aws_security_group.ContainerSecurityGroup[0].id}" },
        { "name" : "AGENT_AUTO_ASSIGN_PUBLIC_IP", "value" : var.agent_auto_assign_public_ip },
        { "name" : "BYOL_MODE", "value" : "False" },
        { "name" : "BLANKET_KMS_ACCESS", "value" : "${tostring(local.blanket_kms_access)}" },
        { "name" : "HAS_LOAD_BALANCER", "value" : "${tostring(var.configure_load_balancer)}" },
        { "name" : "INFO_OPT_OUT", "value" : "${tostring(var.info_opt_out)}" },
        { "name" : "QUARANTINE_BUCKET_NAME_PREFIX", "value" : "${var.quarantine_bucket_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "DYNAMO_DB_TABLE_NAME_PREFIX", "value" : "${aws_appconfig_application.AppConfigAgentApplication.id}." },
        { "name" : "CLUSTER_NAME", "value" : "${aws_ecs_cluster.Cluster.name}" },
        { "name" : "NOTIFICATIONS_TOPIC_NAME", "value" : aws_sns_topic.NotificationsTopic.name },
        { "name" : "APP_CONFIG_DOCUMENT_NAME", "value" : awscc_ssm_document.AppConfigDocument.name },
        { "name" : "APP_CONFIG_DOCUMENT_SCHEMA_NAME", "value" : awscc_ssm_document.AppConfigDocumentSchema.name },
        { "name" : "APP_CONFIG_PROFILE_ID", "value" : aws_appconfig_configuration_profile.AppConfigProfile.configuration_profile_id },
        { "name" : "EVENT_BASED_SCAN_TOPIC_NAME", "value" : "${var.service_name}Topic-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "EVENT_BASED_SCAN_QUEUE_NAME", "value" : "${var.service_name}Queue-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "DC_EVENT_BASED_SCAN_QUEUE_NAME", "value" : "${var.service_name}Queue-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "EFS_SCAN_QUEUE_NAME", "value" : "${var.service_name}Queue-EFS-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "RETRO_SCAN_QUEUE_NAME", "value" : "${var.service_name}RetroQueue-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "CONSOLE_TASK_NAME", "value" : "${var.service_name}Console-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "CONSOLE_SERVICE_NAME", "value" : "${var.configure_load_balancer}" ? "${var.service_name}ConsoleService-LB-${aws_appconfig_application.AppConfigAgentApplication.id}" : "${var.service_name}ConsoleService-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "CONSOLE_ROLE_ARN", "value" : aws_iam_role.ConsoleTaskRole.arn },
        { "name" : "EVENT_AGENT_TASK_NAME", "value" : "${var.service_name}Agent-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "DC_EVENT_AGENT_TASK_NAME", "value" : "${var.service_name}Agent-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "EVENT_AGENT_SERVICE_NAME", "value" : "${var.service_name}AgentService-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "DC_EVENT_AGENT_SERVICE_NAME", "value" : "${var.service_name}AgentService-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "EFS_AGENT_TASK_NAME", "value" : "${var.service_name}Agent-EFS-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "EBS_AGENT_TASK_NAME", "value" : "${var.service_name}Agent-EBS-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "EBS_DC_AGENT_TASK_NAME", "value" : "${var.service_name}Agent-EBS-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "LARGE_FILE_AGENT_TASK_NAME", "value" : "${var.service_name}LargeFileAgent-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "API_AGENT_TASK_NAME", "value" : "${var.service_name}ApiAgent-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "API_AGENT_SERVICE_NAME", "value" : "${var.service_name}ApiAgentService-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "EFS_AGENT_SERVICE_NAME", "value" : "${var.service_name}EfsAgentService-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "API_LB_NAME", "value" : "${var.service_name}ApiLB-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "API_LB_TG_NAME", "value" : "${var.service_name}ApiTG-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "RETRO_AGENT_TASK_NAME", "value" : "${var.service_name}RetroAgent-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "RETRO_AGENT_SERVICE_NAME", "value" : "${var.service_name}RetroAgentService-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "LARGE_EVENT_QUEUE_ALARM_NAME", "value" : "${var.service_name}LargeQueue-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "SMALL_EVENT_QUEUE_ALARM_NAME", "value" : "${var.service_name}SmallQueue-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "DECREASE_AGENTS_SCALING_POLICY_NAME", "value" : "DecreaseAgents-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "INCREASE_AGENTS_SCALING_POLICY_NAME", "value" : "IncreaseAgents-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "LARGE_DC_EVENT_QUEUE_ALARM_NAME", "value" : "${var.service_name}LargeQueue-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "SMALL_DC_EVENT_QUEUE_ALARM_NAME", "value" : "${var.service_name}SmallQueue-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "DECREASE_DC_AGENTS_SCALING_POLICY_NAME", "value" : "DecreaseAgents-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "INCREASE_DC_AGENTS_SCALING_POLICY_NAME", "value" : "IncreaseAgents-DC-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "API_REQUEST_SCALING_POLICY_NAME", "value" : "${var.api_request_scaling_policy_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "API_CPU_SCALING_POLICY_NAME", "value" : "ApiServiceCpuScaling-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "RETRO_QUEUE_NOT_EMPTY_ALARM_NAME", "value" : "${var.service_name}RetroQueueNotEmpty-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "RETRO_QUEUE_EMPTY_ALARM_NAME", "value" : "${var.service_name}RetroQueueEmpty-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "REMOVE_RETRO_AGENTS_SCALING_POLICY_NAME", "value" : "RemoveRetroAgents-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "SET_RETRO_AGENTS_SCALING_POLICY_NAME", "value" : "SetRetroAgents-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "AGENT_SECURITY_GROUP_NAME", "value" : "${var.service_name}AgentSecurityGroup-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "CROSS_ACCOUNT_ROLE_NAME", "value" : "${var.service_name}RemoteRole-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "CROSS_ACCOUNT_POLICY_NAME", "value" : "${var.service_name}RemotePolicy-${aws_appconfig_application.AppConfigAgentApplication.id}" },
        { "name" : "CROSS_ACCOUNT_EVENT_BRIDGE_ROLE_NAME", "value" : aws_iam_role.EventBridgeRole[0].name },
        { "name" : "CROSS_ACCOUNT_EVENT_BRIDGE_POLICY_NAME", "value" : aws_iam_policy.EventBridgePolicy.name },
        { "name" : "CUSTOM_RESOURCE_TAGS", "value" : join(",", [for key, value in var.custom_resource_tags : "${key}=${value}"]) },
        { "name" : "DLP_CCL_DIR", "value" : "/cssdlp" },
        { "name" : "DLP_CCL_FILE_NAME", "value" : "PredefinedContentControlLists.xml" },
        { "name" : "PROXY_HOST", "value" : "${local.use_proxy}" ? "${var.proxy_host}" : "" },
        { "name" : "PROXY_PORT", "value" : "${local.use_proxy}" ? "${var.proxy_port}" : "" },
        { "name" : "PRODUCT_MODE", "value" : "${var.product_mode}" },
        { "name" : "TEMPLATE_VARIATION", "value" : "${var.template_variation}" },
        { "name" : "DEPLOYMENT_TYPE", "value" : "terraform" },
        { "name" : "BUCKETS_TO_PROTECT", "value" : "${var.buckets_to_protect}" },
        { "name" : "LOG_LEVEL", "value" : "Info" },
      ]
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group         = aws_cloudwatch_log_group.cloudwatch_logs_group.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      HealthCheck = {
        Command = [
          "CMD-SHELL",
          "curl -k -f https://localhost/api/health || exit 1"
        ]
        Interval = 60
        Timeout  = 5
        Retries  = 3
      }
    }
  ])
  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleTaskDefinition" },
    var.custom_resource_tags
  )
}
