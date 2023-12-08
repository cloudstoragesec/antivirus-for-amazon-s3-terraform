resource "aws_ssm_parameter" "DynamoTableNamePrefixParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/DynamoTableNamePrefix"
  type  = "String"
  value = "${aws_appconfig_application.AppConfigAgentApplication.id}."
}

resource "aws_ssm_parameter" "DynamoPointInTimeRecoveryEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/DynamoPointInTimeRecoveryEnabled"
  type  = "String"
  value = "false"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "AgentEcrImageUrlParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentEcrImageUrl"
  type  = "String"
  value = local.agent_image_url
}

resource "aws_ssm_parameter" "MaxNumAgentsParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/MaxNumAgents"
  type  = "String"
  value = "12"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "MinNumAgentsParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/MinNumAgents"
  type  = "String"
  value = "1"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "QueueScalingThresholdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/QueueScalingThreshold"
  type  = "String"
  value = "1000"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "AgentCpuParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentCpu"
  type  = "String"
  value = "1024"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "AgentMemoryParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentMemory"
  type  = "String"
  value = "3072"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "AgentDiskSizeParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentDiskSize"
  type  = "String"
  value = "20"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "EnableLargeFileScanningParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/EnableLargeFileScanning"
  type  = "String"
  value = "false"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "StorageAssessmentEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/StorageAssessmentEnabled"
  type  = "String"
  value = "false"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "LargeFileDiskSizeParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LargeFileDiskSize"
  type  = "String"
  value = "2000"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "LargeFileEC2TagsParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LargeFileEC2Tags"
  type  = "String"
  value = "CloudStorageSec-[appId]=EC2Instance"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "SubdomainParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/Subdomain"
  type  = "String"
  value = "${var.aws_account}-${aws_appconfig_application.AppConfigAgentApplication.id}"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "EmailParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/Email"
  type  = "String"
  value = var.email
}

resource "aws_ssm_parameter" "UserNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/UserName"
  type  = "String"
  value = var.username
}

resource "aws_ssm_parameter" "StackNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/StackName"
  type  = "String"
  value = var.service_name
}

resource "aws_ssm_parameter" "PrivateMirrorParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/PrivateMirror"
  type  = "String"
  value = "!!none_chosen!!"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "LastUpgradeNotesSeenParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LastUpgradeNotesSeen"
  type  = "String"
  value = "v1.00.000"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "LastPostUpgradeProcedureParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LastPostUpgradeProcedure"
  type  = "String"
  value = "v1.00.000"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "RegionParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/AWS/Region"
  type  = "String"
  value = var.aws_region
}

resource "aws_ssm_parameter" "UserPoolClientIdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/AWS/UserPoolClientId"
  type  = "String"
  value = aws_cognito_user_pool_client.UserPoolClient.id
}

resource "aws_ssm_parameter" "UserPoolClientSecretParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/AWS/UserPoolClientSecret"
  type  = "String"
  value = aws_cognito_user_pool_client.UserPoolClient.client_secret
}
resource "aws_ssm_parameter" "UserPoolIdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/AWS/UserPoolId"
  type  = "String"
  value = aws_cognito_user_pool.UserPool.id
}

resource "aws_ssm_parameter" "OnlyScanWhenQueueThresholdExceededParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/OnlyScanWhenQueueThresholdExceeded"
  type  = "String"
  value = "false"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "QuarantineInPrimaryAccountParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/QuarantineInPrimaryAccount"
  type  = "String"
  value = "false"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "SecurityHubEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/SecurityHubEnabled"
  type  = "String"
  value = "false"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "AgentScanningEngineParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentScanningEngine"
  type  = "String"
  value = var.agent_scanning_engine
}

resource "aws_ssm_parameter" "MultiEngineScanningModeParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/MultiEngineScanningMode"
  type  = "String"
  value = var.multi_engine_scanning_mode
}

resource "aws_ssm_parameter" "EcrAccountIdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/EcrAccountId"
  type  = "String"
  value = var.ecr_account
}

resource "aws_ssm_parameter" "QuarantineBucketDaysToExpireParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/QuarantineBucketDaysToExpire"
  type  = "String"
  value = "0"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "AutoProtectBucketTagKeyParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AutoProtectBucketTagKey"
  type  = "String"
  value = "CloudStorageSecAutoProtect-${aws_appconfig_application.AppConfigAgentApplication.id}"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "CloudTrailLakeEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeEnabled"
  type  = "String"
  value = "false"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "CloudTrailLakeEventDataStoreNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeEventDataStoreName"
  type  = "String"
  value = "CloudTrailLakeEventDataStoreName-${aws_appconfig_application.AppConfigAgentApplication.id}"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "CloudTrailLakeChannelNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeChannelName"
  type  = "String"
  value = "CloudStorageSecCloudTrailLake-${aws_appconfig_application.AppConfigAgentApplication.id}"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "CloudTrailLakeChannelArnParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeArn"
  type  = "String"
  value = "unknown"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "EventBridgeNotificationsEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/EventBridgeNotificationsEnabled"
  type  = "String"
  value = tostring(local.eventbridge_notifications_enabled)
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "EventBridgeNotificationsBusNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/EventBridgeNotificationsBusName"
  type  = "String"
  value = var.eventbridge_notifications_bus_name
  lifecycle {
    ignore_changes = [value]
  }
}
