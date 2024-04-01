# 

######### AppConfig ###############
moved {
  from = random_id.stack
  to   = module.cloud-storage-security.random_id.stack
}
moved {
  from = aws_appconfig_application.AppConfigAgentApplication
  to   = module.cloud-storage-security.aws_appconfig_application.agent
}
moved {
  from = aws_appconfig_environment.AppConfigAgentEnvironment
  to   = module.cloud-storage-security.aws_appconfig_environment.agent
}
moved {
  from = aws_appconfig_deployment_strategy.AppConfigAgentDeploymentStrategy
  to   = module.cloud-storage-security.aws_appconfig_deployment_strategy.agent
}
moved {
  from = awscc_ssm_document.AppConfigDocument
  to   = module.cloud-storage-security.awscc_ssm_document.appconfig_document
}
moved {
  from = aws_appconfig_configuration_profile.AppConfigProfile
  to   = module.cloud-storage-security.aws_appconfig_configuration_profile.agent
}
moved {
  from = aws_appconfig_deployment.AppConfigAgentDeployment
  to   = module.cloud-storage-security.aws_appconfig_deployment.agent
}
######### DDB ###############
moved {
  from = aws_dynamodb_table.css-dynamodb-table[0]
  to   = module.cloud-storage-security.aws_dynamodb_table.buckets
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[1]
  to   = module.cloud-storage-security.aws_dynamodb_table.efs_volumes
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[2]
  to   = module.cloud-storage-security.aws_dynamodb_table.ebs_volumes
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[3]
  to   = module.cloud-storage-security.aws_dynamodb_table.subnets
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[4]
  to   = module.cloud-storage-security.aws_dynamodb_table.console
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[5]
  to   = module.cloud-storage-security.aws_dynamodb_table.linked_accounts
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[6]
  to   = module.cloud-storage-security.aws_dynamodb_table.work_docs_connections
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[7]
  to   = module.cloud-storage-security.aws_dynamodb_table.groups
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[8]
  to   = module.cloud-storage-security.aws_dynamodb_table.visible_groups
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[9]
  to   = module.cloud-storage-security.aws_dynamodb_table.scheduled_scans
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[10]
  to   = module.cloud-storage-security.aws_dynamodb_table.scheduled_classifications
}
moved {
  from = aws_dynamodb_table.css-dynamodb-table[11]
  to   = module.cloud-storage-security.aws_dynamodb_table.deployment_status
}
moved {
  from = aws_dynamodb_table.AgentDataTable
  to   = module.cloud-storage-security.aws_dynamodb_table.agent_data
}
moved {
  from = aws_dynamodb_table.AgentsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.agents
}
moved {
  from = aws_dynamodb_table.AllowedInfectedFilesTable
  to   = module.cloud-storage-security.aws_dynamodb_table.allowed_infected_files
}
moved {
  from = aws_dynamodb_table.BucketClassificationStatisticsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.bucket_classification_statistics
}
moved {
  from = aws_dynamodb_table.BucketScanStatisticsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.bucket_scan_statistics
}
moved {
  from = aws_dynamodb_table.ClassificationResultsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.classification_results
}
moved {
  from = aws_dynamodb_table.DailyScanStatisticsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.daily_scan_statistics
}
moved {
  from = aws_dynamodb_table.FileCountTable
  to   = module.cloud-storage-security.aws_dynamodb_table.file_count
}
moved {
  from = aws_dynamodb_table.GroupMembershipTable
  to   = module.cloud-storage-security.aws_dynamodb_table.group_membership
}
moved {
  from = aws_dynamodb_table.JobsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.jobs
}
moved {
  from = aws_dynamodb_table.LicenseFileHistoryTable
  to   = module.cloud-storage-security.aws_dynamodb_table.license_file_history
}
moved {
  from = aws_dynamodb_table.LinkedAccountMembershipTable
  to   = module.cloud-storage-security.aws_dynamodb_table.linked_account_membership
}
moved {
  from = aws_dynamodb_table.MonthlyScanStatisticsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.monthly_scan_statistics
}
moved {
  from = aws_dynamodb_table.NotificationsTable
  to   = module.cloud-storage-security.aws_dynamodb_table.notifications
}
moved {
  from = aws_dynamodb_table.ProactiveMonitorStatusesTable
  to   = module.cloud-storage-security.aws_dynamodb_table.proactive_monitor_statuses
}
moved {
  from = aws_dynamodb_table.ProblemFilesTable
  to   = module.cloud-storage-security.aws_dynamodb_table.problem_files
}
moved {
  from = aws_dynamodb_table.SophosTapDataTable
  to   = module.cloud-storage-security.aws_dynamodb_table.sophos_tap_data
}
moved {
  from = aws_dynamodb_table.StorageAnalysisTable
  to   = module.cloud-storage-security.aws_dynamodb_table.storage_analysis
}
moved {
  from = aws_dynamodb_table.fsx_volumes
  to   = module.cloud-storage-security.aws_dynamodb_table.fsx_volumes
}
moved {
  from = aws_dynamodb_table.job_networking
  to   = module.cloud-storage-security.aws_dynamodb_table.job_networking
}

######### SSM ###############
moved {
  from = aws_ssm_parameter.DynamoTableNamePrefixParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.dynamo_table_name_prefix
}
moved {
  from = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.dynamo_point_in_time_recovery_enabled
}
moved {
  from = aws_ssm_parameter.AgentEcrImageUrlParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.agent_ecr_image_url
}
moved {
  from = aws_ssm_parameter.MaxNumAgentsParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.max_num_agents
}
moved {
  from = aws_ssm_parameter.MinNumAgentsParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.min_num_agents
}
moved {
  from = aws_ssm_parameter.QueueScalingThresholdParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.queue_scaling_threshold
}
moved {
  from = aws_ssm_parameter.AgentCpuParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.agent_cpu
}
moved {
  from = aws_ssm_parameter.AgentMemoryParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.agent_memory
}
moved {
  from = aws_ssm_parameter.AgentDiskSizeParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.agent_disk_size
}
moved {
  from = aws_ssm_parameter.EnableLargeFileScanningParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.enable_large_file_scanning
}
moved {
  from = aws_ssm_parameter.StorageAssessmentEnabledParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.storage_assessment_enabled
}
moved {
  from = aws_ssm_parameter.LargeFileDiskSizeParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.large_file_disk_size
}
moved {
  from = aws_ssm_parameter.LargeFileEC2TagsParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.large_file_ec2_tags
}
moved {
  from = aws_ssm_parameter.SubdomainParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.subdomain
}
moved {
  from = aws_ssm_parameter.EmailParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.email
}
moved {
  from = aws_ssm_parameter.UserNameParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.user_name
}
moved {
  from = aws_ssm_parameter.StackNameParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.stack_name
}
moved {
  from = aws_ssm_parameter.PrivateMirrorParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.private_mirror
}
moved {
  from = aws_ssm_parameter.LastUpgradeNotesSeenParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.last_upgrade_notes_seen
}
moved {
  from = aws_ssm_parameter.LastPostUpgradeProcedureParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.last_post_upgrade_procedure
}
moved {
  from = aws_ssm_parameter.RegionParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.region
}
moved {
  from = aws_ssm_parameter.UserPoolClientIdParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.user_pool_client_id
}
moved {
  from = aws_ssm_parameter.UserPoolClientSecretParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.user_pool_client_secret
}
moved {
  from = aws_ssm_parameter.UserPoolIdParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.user_pool_id
}
moved {
  from = aws_ssm_parameter.OnlyScanWhenQueueThresholdExceededParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.only_scan_when_queue_threshold_exceeded
}
moved {
  from = aws_ssm_parameter.QuarantineInPrimaryAccountParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.quarantine_in_primary_account
}
moved {
  from = aws_ssm_parameter.SecurityHubEnabledParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.security_hub_enabled
}
moved {
  from = aws_ssm_parameter.AgentScanningEngineParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.agent_scanning_engine
}
moved {
  from = aws_ssm_parameter.MultiEngineScanningModeParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.multi_engine_scanning_mode
}
moved {
  from = aws_ssm_parameter.EcrAccountIdParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.ecr_account_id
}
moved {
  from = aws_ssm_parameter.QuarantineBucketDaysToExpireParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.quarantine_bucket_days_to_expire
}
moved {
  from = aws_ssm_parameter.AutoProtectBucketTagKeyParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.auto_protect_bucket_tag_key
}
moved {
  from = aws_ssm_parameter.CloudTrailLakeEnabledParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.cloud_trail_lake_enabled
}
moved {
  from = aws_ssm_parameter.CloudTrailLakeEventDataStoreNameParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.cloud_trail_lake_event_data_store_name
}
moved {
  from = aws_ssm_parameter.CloudTrailLakeChannelNameParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.cloud_trail_lake_channel_name
}
moved {
  from = aws_ssm_parameter.CloudTrailLakeChannelArnParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.cloud_trail_lake_channel_arn
}
moved {
  from = aws_ssm_parameter.EventBridgeNotificationsEnabledParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.event_bridge_notifications_enabled
}
moved {
  from = aws_ssm_parameter.EventBridgeNotificationsBusNameParameter
  to   = module.cloud-storage-security.aws_ssm_parameter.event_bridge_notifications_bus_name
}

######### ECS ###############
moved {
  from = aws_ecs_cluster.Cluster
  to   = module.cloud-storage-security.aws_ecs_cluster.main
}
moved {
  from = aws_ecs_service.Service[0]
  to   = module.cloud-storage-security.aws_ecs_service.main[0]
}
moved {
  from = aws_ecs_service.ServiceWithLB[0]
  to   = module.cloud-storage-security.aws_ecs_service.with_load_balancer[0]
}
moved {
  from = aws_lb_target_group.TargetGroup[0]
  to   = module.cloud-storage-security.aws_lb_target_group.main[0]
}
moved {
  from = aws_lb_listener.Listener[0]
  to   = module.cloud-storage-security.aws_lb_listener.main[0]
}
moved {
  from = aws_lb.LoadBalancer[0]
  to   = module.cloud-storage-security.aws_lb.main[0]
}
moved {
  from = aws_ecs_task_definition.TaskDefinition
  to   = module.cloud-storage-security.aws_ecs_task_definition.console
}
######### IAM ###############
moved {
  from = aws_iam_role.AppConfigAgentConfigurationDocumentRole
  to   = module.cloud-storage-security.aws_iam_role.appconfig_agent_configuration_document
}
moved {
  from = aws_iam_role_policy.AppConfigAgentConfigurationDocumentPolicy
  to   = module.cloud-storage-security.aws_iam_role_policy.appconfig_agent_configuration_document
}
moved {
  from = aws_iam_role.UserPoolSnsRole
  to   = module.cloud-storage-security.aws_iam_role.user_pool_sns
}
moved {
  from = aws_iam_role_policy.UserPoolSnsPolicy
  to   = module.cloud-storage-security.aws_iam_role_policy.user_pool_sns
}
moved {
  from = aws_iam_role.ConsoleTaskRole
  to   = module.cloud-storage-security.aws_iam_role.console_task
}
moved {
  from = aws_iam_role_policy.ConsoleTaskPolicy
  to   = module.cloud-storage-security.aws_iam_role_policy.console_task
}
moved {
  from = aws_iam_role_policy.ConsoleTaskPolicyApiLb
  to   = module.cloud-storage-security.aws_iam_role_policy.console_task_api_lb
}
moved {
  from = aws_iam_role_policy.ConsoleTaskPolicyAwsLicensing
  to   = module.cloud-storage-security.aws_iam_role_policy.console_task_aws_licensing
}
moved {
  from = aws_iam_role_policy.CloudTrailLakePolicy
  to   = module.cloud-storage-security.aws_iam_role_policy.cloud_trail_lake_policy
}
moved {
  from = aws_iam_role_policy.CustomCMKPolicy[0]
  to   = module.cloud-storage-security.aws_iam_role_policy.custom_CMK[0]
}
moved {
  from = aws_iam_role_policy_attachment.dynamo_cmk_console_policy_attach[0]
  to   = module.cloud-storage-security.aws_iam_role_policy_attachment.dynamo_cmk_console_policy_attach[0]
}
moved {
  from = aws_iam_role_policy_attachment.dynamo_cmk_agent_policy_attach[0]
  to   = module.cloud-storage-security.aws_iam_role_policy_attachment.dynamo_cmk_agent_policy_attach[0]
}
moved {
  from = aws_iam_role.AgentTaskRole
  to   = module.cloud-storage-security.aws_iam_role.agent_task
}
moved {
  from = aws_iam_role_policy.AgentTaskPolicy
  to   = module.cloud-storage-security.aws_iam_role_policy.agent_task
}
moved {
  from = aws_iam_role.ExecutionRole
  to   = module.cloud-storage-security.aws_iam_role.execution
}
moved {
  from = aws_iam_role.Ec2ContainerRole
  to   = module.cloud-storage-security.aws_iam_role.ec2_container
}
moved {
  from = aws_iam_role_policy.Ec2ContainerPolicy
  to   = module.cloud-storage-security.aws_iam_role_policy.ec2_container
}
moved {
  from = aws_iam_instance_profile.Ec2ContainerInstanceProfile
  to   = module.cloud-storage-security.aws_iam_instance_profile.ec2_container
}
moved {
  from = aws_iam_role.EventBridgeRole[0]
  to   = module.cloud-storage-security.aws_iam_role.event_bridge[0]
}
moved {
  from = aws_iam_policy.EventBridgePolicy
  to   = module.cloud-storage-security.aws_iam_policy.event_bridge
}
moved {
  from = aws_iam_role_policy_attachment.event_bridge_policy_attach
  to   = module.cloud-storage-security.aws_iam_role_policy_attachment.event_bridge_policy_attach
}
moved {
  from = aws_iam_policy.proactive_notifications_event_bridge[0]
  to   = module.cloud-storage-security.aws_iam_policy.proactive_notifications_event_bridge[0]
}
moved {
  from = aws_iam_role_policy_attachment.custom_event_bridge_console_policy_attach[0]
  to   = module.cloud-storage-security.aws_iam_role_policy_attachment.custom_event_bridge_console_policy_attach[0]
}
moved {
  from = aws_iam_role_policy_attachment.custom_event_bridge_agent_policy_attach[0]
  to   = module.cloud-storage-security.aws_iam_role_policy_attachment.custom_event_bridge_agent_policy_attach[0]
}
######### Cognito ###############
moved {
  from = aws_cognito_user_pool.UserPool
  to   = module.cloud-storage-security.aws_cognito_user_pool.main
}
moved {
  from = aws_cognito_user_pool_client.UserPoolClient
  to   = module.cloud-storage-security.aws_cognito_user_pool_client.main
}
moved {
  from = aws_cognito_user_group.UserPoolAdminGroup
  to   = module.cloud-storage-security.aws_cognito_user_group.admins
}
moved {
  from = aws_cognito_user_group.UserPoolUserGroup
  to   = module.cloud-storage-security.aws_cognito_user_group.users
}
moved {
  from = aws_cognito_user_group.UserPoolApiGroup
  to   = module.cloud-storage-security.aws_cognito_user_group.api
}
moved {
  from = aws_cognito_user_group.UserPoolPrimaryGroup
  to   = module.cloud-storage-security.aws_cognito_user_group.primary
}
moved {
  from = aws_cognito_user.UserPoolUser
  to   = module.cloud-storage-security.aws_cognito_user.admin
}
moved {
  from = aws_cognito_user_in_group.UserPoolUserAdminGroupAttachment
  to   = module.cloud-storage-security.aws_cognito_user_in_group.admin
}
######### Cloudwatch ###############
moved {
  from = aws_cloudwatch_log_group.cloudwatch_logs_group
  to   = module.cloud-storage-security.aws_cloudwatch_log_group.main
}
moved {
  from = aws_cloudwatch_metric_alarm.health_check_console_alarm
  to   = module.cloud-storage-security.aws_cloudwatch_metric_alarm.health_check_console
}
moved {
  from = aws_cloudwatch_event_bus.proactive_notifications
  to   = module.cloud-storage-security.aws_cloudwatch_event_bus.proactive_notifications
}
######### SG ###############
moved {
  from = aws_security_group.ContainerSecurityGroup[0]
  to   = module.cloud-storage-security.aws_security_group.console[0]
}
moved {
  from = aws_security_group.ContainerSecurityGroupWithLB[0]
  to   = module.cloud-storage-security.aws_security_group.console_with_load_balancer[0]
}
moved {
  from = aws_security_group.LoadBalancerSecurityGroup[0]
  to   = module.cloud-storage-security.aws_security_group.load_balancer[0]
}
######### SNS ###############
moved {
  from = aws_sns_topic.NotificationsTopic
  to   = module.cloud-storage-security.aws_sns_topic.notifications
}
moved {
  from = aws_sns_topic_policy.NotificationsTopicPolicy
  to   = module.cloud-storage-security.aws_sns_topic_policy.notifications_topic
}
moved {
  from = aws_iam_policy_document.TopicPolicyDocument
  to   = module.cloud-storage-security.aws_iam_policy_document.notifications_topic
}