#This parameter is being used for creating table names, it contains app id, so that tables are prefixed with app id, but its already done through actual app id, so is this required #Penfding
resource "aws_ssm_parameter" "DynamoTableNamePrefixParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/DynamoTableNamePrefix"
  type  = "String"
  value = "${aws_appconfig_application.AppConfigAgentApplication.id}."
}

resource "aws_ssm_parameter" "DynamoPointInTimeRecoveryEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/DynamoPointInTimeRecoveryEnabled"
  type  = "String"
  value = "false"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "AgentEcrImageUrlParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentEcrImageUrl"
  type  = "String"
  value = "${aws_ssm_parameter.EcrAccountIdParameter.value}.dkr.ecr.<region>.amazonaws.com/cloudstoragesecurity/agent:v6.04.006"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "MaxNumAgentsParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/MaxNumAgents"
  type  = "String"
  value = "12"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "MinNumAgentsParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/MinNumAgents"
  type  = "String"
  value = "1"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "QueueScalingThresholdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/QueueScalingThreshold"
  type  = "String"
  value = "1000"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "AgentCpuParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentCpu"
  type  = "String"
  value = "1024"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "AgentMemoryParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentMemory"
  type  = "String"
  value = "3072"
}
#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "AgentDiskSizeParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentDiskSize"
  type  = "String"
  value = "20"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "EnableLargeFileScanningParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/EnableLargeFileScanning"
  type  = "String"
  value = "false"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "StorageAssessmentEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/StorageAssessmentEnabled"
  type  = "String"
  value = "false"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending

resource "aws_ssm_parameter" "LargeFileDiskSizeParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LargeFileDiskSize"
  type  = "String"
  value = "2000"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its hardcoded #Pending
resource "aws_ssm_parameter" "LargeFileEC2TagsParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LargeFileEC2Tags"
  type  = "String"
  value = "CloudStorageSec-[appId]=EC2Instance"
}

#This is being used as output and userclientpool url, for both I've used application id along with variables, same as what value has been used for this ssm, kidnly confirm it it can be kepts as it is, as when the value will be changed hwere will be changed there #Pending
resource "aws_ssm_parameter" "SubdomainParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/Subdomain"
  type  = "String"
  value = "${var.aws_account}-${aws_appconfig_application.AppConfigAgentApplication.id}"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its variable #Pending
resource "aws_ssm_parameter" "EmailParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/Email"
  type  = "String"
  value = "${var.Email}"
}

#Currently not being used anywhere in CFT apart from parameter, but have kept it just verify its varibale #Pending
resource "aws_ssm_parameter" "UserNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/UserName"
  type  = "String"
  value = "${var.UserName}"
}

resource "aws_ssm_parameter" "StackNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/StackName"
  type  = "String"
  value = "${var.service_name}"
}

resource "aws_ssm_parameter" "PrivateMirrorParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/PrivateMirror"
  type  = "String"
  value = "!!none_chosen!!"
}

resource "aws_ssm_parameter" "LastUpgradeNotesSeenParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LastUpgradeNotesSeen"
  type  = "String"
  value = "v1.00.000"
}

resource "aws_ssm_parameter" "LastPostUpgradeProcedureParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/LastPostUpgradeProcedure"
  type  = "String"
  value = "v1.00.000"
}

resource "aws_ssm_parameter" "RegionParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Region"
  type  = "String"
  value = "${var.aws_region}"
}

resource "aws_ssm_parameter" "UserPoolClientIdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/UserPoolClientId"
  type  = "String"
  value = "${aws_cognito_user_pool_client.UserPoolClient.id}"
}

resource "aws_ssm_parameter" "UserPoolClientSecretParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/UserPoolClientSecret"
  type  = "String"
  value = "${aws_cognito_user_pool_client.UserPoolClient.client_secret}"
}
resource "aws_ssm_parameter" "UserPoolIdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/UserPoolId"
  type  = "String"
  value = "${aws_cognito_user_pool.UserPool.id}"
}

resource "aws_ssm_parameter" "OnlyScanWhenQueueThresholdExceededParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/OnlyScanWhenQueueThresholdExceeded"
  type  = "String"
  value = "false"
}

resource "aws_ssm_parameter" "QuarantineInPrimaryAccountParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/QuarantineInPrimaryAccount"
  type  = "String"
  value = "false"
}

resource "aws_ssm_parameter" "SecurityHubEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/SecurityHubEnabled"
  type  = "String"
  value = "false"
}

resource "aws_ssm_parameter" "AgentScanningEngineParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AgentScanningEngine"
  type  = "String"
  value = "${var.agentscanningengine}"
}


resource "aws_ssm_parameter" "MultiEngineScanningModeParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/MultiEngineScanningMode"
  type  = "String"
  value = "${var.multienginescanningengine}"
}

resource "aws_ssm_parameter" "EcrAccountIdParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/EcrAccountId"
  type  = "String"
  value = "${var.ecr_account}"
}

resource "aws_ssm_parameter" "QuarantineBucketDaysToExpireParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/QuarantineBucketDaysToExpire"
  type  = "String"
  value = "0"
}

resource "aws_ssm_parameter" "AutoProtectBucketTagKeyParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/AutoProtectBucketTagKey"
  type  = "String"
  value = "CloudStorageSecAutoProtect-${aws_appconfig_application.AppConfigAgentApplication.id}"
}

resource "aws_ssm_parameter" "CloudTrailLakeEnabledParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeEnabled"
  type  = "String"
  value = "false"
}

resource "aws_ssm_parameter" "CloudTrailLakeEventDataStoreNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeEventDataStoreName"
  type  = "String"
  value = "CloudTrailLakeEventDataStoreName-${aws_appconfig_application.AppConfigAgentApplication.id}"
}

resource "aws_ssm_parameter" "CloudTrailLakeChannelNameParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeChannelName"
  type  = "String"
  value = "CloudStorageSecCloudTrailLake-${aws_appconfig_application.AppConfigAgentApplication.id}"
}

resource "aws_ssm_parameter" "CloudTrailLakeChannelArnParameter" {
  name  = "/${var.parameter_prefix}-${aws_appconfig_application.AppConfigAgentApplication.id}/Config/CloudTrailLakeArn"
  type  = "String"
  value = "unknown"
}
