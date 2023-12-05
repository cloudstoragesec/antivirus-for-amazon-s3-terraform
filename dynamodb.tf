resource "aws_dynamodb_table" "css-dynamodb-table" {
  count        = 13
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.${var.tables[count.index].name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.tables[count.index].hash_key
  range_key    = try(var.tables[count.index].range_key, null)
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  dynamic "attribute" {
    for_each = var.tables[count.index].attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

variable "tables" {
  type = list(object({
    name     = string
    hash_key = string
    range_key = optional(string)
    attributes = list(object({
      name = string
      type = string
    }))
  }))

  default = [
    {
      name     = "Buckets"
      hash_key = "Name"
      attributes = [
        { name = "Name", type = "S" },
      ]
    },
    {
      name     = "EfsVolumes"
      hash_key = "Id"
      attributes = [
        { name = "Id", type = "S" },
      ]
    },
    {
      name     = "EbsVolumes"
      hash_key = "Id"
      attributes = [
        { name = "Id", type = "S" },
      ]
    },
    {
      name     = "Subnets"
      hash_key = "Region"
      attributes = [
        { name = "Region", type = "S" },
      ]
    },
    {
      name      = "JobNetworking"
      hash_key  = "PK"
      range_key = "SK"
      attributes = [
        { name = "PK", type = "S" },
        { name = "SK", type = "S" },
      ]
    },
    {
      name     = "Console"
      hash_key = "ApplicationId"
      attributes = [
        { name = "ApplicationId", type = "S" },
      ]

    },
    {
      name     = "LinkedAccounts"
      hash_key = "AccountId"
      attributes = [
        { name = "AccountId", type = "S" },
      ]

    },
    {
      name     = "WorkDocsConnections"
      hash_key = "OrganizationId"
      attributes = [
        { name = "OrganizationId", type = "S" },
      ]

    },
    {
      name     = "Groups"
      hash_key = "Id"
      attributes = [
        { name = "Id", type = "S" },
      ]

    },
    {
      name     = "VisibleGroups"
      hash_key = "Username"
      attributes = [
        { name = "Username", type = "S" },
      ]

    },
    {
      name     = "ScheduledScans"
      hash_key = "ScheduleName"
      attributes = [
        { name = "ScheduleName", type = "S" },
      ]

    },
    {
      name     = "ScheduledClassifications"
      hash_key = "Name"
      attributes = [
        { name = "Name", type = "S" },
      ]

    },
    {
      name     = "DeploymentStatus"
      hash_key = "Region"
      attributes = [
        { name = "Region", type = "S" },
      ]

    },
  ]
}

resource "aws_dynamodb_table" "ProactiveMonitorStatusesTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.ProactiveMonitorStatuses"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Name"
  range_key    = "Region"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "Name"
    type = "S"
  }

  attribute {
    name = "Region"
    type = "S"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "StorageAnalysisTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.StorageAnalysis"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "BucketName"
  range_key    = "ScanDate"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "BucketName"
    type = "S"
  }

  attribute {
    name = "ScanDate"
    type = "S"
  }

  attribute {
    name = "TrackerFlag"
    type = "N"
  }

  global_secondary_index {
    name            = "DateIndex"
    hash_key        = "TrackerFlag"
    range_key       = "ScanDate"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "FileCountTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.FileCount"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ScanDate"
  range_key    = "Guid"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "ScanDate"
    type = "S"
  }

  attribute {
    name = "Guid"
    type = "S"
  }

  attribute {
    name = "TrackerFlag"
    type = "N"
  }

  global_secondary_index {
    name            = "DateIndex"
    hash_key        = "TrackerFlag"
    range_key       = "ScanDate"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "AgentsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.Agents"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "AgentId"
  range_key    = "DeactivationDate"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "AgentId"
    type = "S"
  }

  attribute {
    name = "DeactivationDate"
    type = "S"
  }

  attribute {
    name = "Active"
    type = "N"
  }

  global_secondary_index {
    name            = "ActiveAndDeactivationDateIndex"
    hash_key        = "Active"
    range_key       = "DeactivationDate"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "AgentDataTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.AgentData"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "AgentId"
  range_key    = "Tstp"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "AgentId"
    type = "S"
  }

  attribute {
    name = "Tstp"
    type = "N"
  }

  attribute {
    name = "TrackerFlag"
    type = "N"
  }

  global_secondary_index {
    name            = "TstpIndex"
    hash_key        = "TrackerFlag"
    range_key       = "Tstp"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "BucketScanStatisticsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.BucketScanStatistics"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "BucketName"
  range_key    = "Date"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "BucketName"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }

  attribute {
    name = "TrackerFlag"
    type = "N"
  }

  global_secondary_index {
    name            = "DateIndex"
    hash_key        = "TrackerFlag"
    range_key       = "Date"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "BucketClassificationStatisticsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.BucketClassificationStatistics"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "BucketName"
  range_key    = "Date"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "BucketName"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }

  global_secondary_index {
    name            = "DateIndex"
    hash_key        = "Date"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "SophosTapDataTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.SophosTapData"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Date"
  range_key    = "Tstp"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "Date"
    type = "S"
  }

  attribute {
    name = "Tstp"
    type = "N"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}
resource "aws_dynamodb_table" "DailyScanStatisticsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.DailyScanStatistics"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "AccountId"
  range_key    = "Date"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "AccountId"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "ScanType"
    type = "S"
  }

  attribute {
    name = "ScanEngine"
    type = "S"
  }
  attribute {
    name = "TrackerFlag"
    type = "N"
  }

  global_secondary_index {
    name            = "ScanTypeAndScanEngine"
    hash_key        = "ScanType"
    range_key       = "ScanEngine"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "LastRecordDate"
    hash_key        = "TrackerFlag"
    range_key       = "Date"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "MonthlyScanStatisticsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.MonthlyScanStatistics"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "AccountId"
  range_key    = "Date"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "AccountId"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "TrackerFlag"
    type = "N"
  }

  attribute {
    name = "ScanType"
    type = "S"
  }
  attribute {
    name = "ScanEngine"
    type = "S"
  }

  global_secondary_index {
    name            = "ScanTypeAndScanEngine"
    hash_key        = "ScanType"
    range_key       = "ScanEngine"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "LastRecordDate"
    hash_key        = "TrackerFlag"
    range_key       = "Date"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "ProblemFilesTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.ProblemFiles"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Guid"
  range_key    = "DateScanned"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "Guid"
    type = "S"
  }

  attribute {
    name = "DateScanned"
    type = "S"
  }
  attribute {
    name = "AccountId"
    type = "S"
  }
  attribute {
    name = "AccountIdResult"
    type = "S"
  }

  global_secondary_index {
    name            = "AccountIdAndDateScanned"
    hash_key        = "AccountId"
    range_key       = "DateScanned"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "AccountIdResultAndDateScanned"
    hash_key        = "AccountIdResult"
    range_key       = "DateScanned"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "ClassificationResultsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.ClassificationResults"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Date"
  range_key    = "Guid"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "Date"
    type = "S"
  }

  attribute {
    name = "Guid"
    type = "S"
  }
  attribute {
    name = "AccountId"
    type = "S"
  }

  global_secondary_index {
    name            = "AccountIdAndGuid"
    hash_key        = "AccountId"
    range_key       = "Guid"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "AllowedInfectedFilesTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.AllowedInfectedFiles"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "BucketAndKey"
  range_key    = "VirusName"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "BucketAndKey"
    type = "S"
  }

  attribute {
    name = "VirusName"
    type = "S"
  }
  attribute {
    name = "DateAdded"
    type = "S"
  }
  attribute {
    name = "Active"
    type = "N"
  }

  global_secondary_index {
    name            = "ActiveAndDateAdded"
    hash_key        = "Active"
    range_key       = "DateAdded"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "GroupMembershipTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.GroupMembership"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ParentGroupId"
  range_key    = "ChildGroupId"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "ParentGroupId"
    type = "S"
  }

  attribute {
    name = "ChildGroupId"
    type = "S"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "JobsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.Jobs"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Type"
  range_key    = "Date"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "Type"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "Status"
    type = "N"
  }
  attribute {
    name = "ParentJobId"
    type = "S"
  }

  global_secondary_index {
    name            = "Status"
    hash_key        = "Status"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "TypeAndParentJobId"
    hash_key        = "Type"
    range_key       = "ParentJobId"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "LinkedAccountMembershipTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.LinkedAccountMembership"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "GroupId"
  range_key    = "AccountId"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "GroupId"
    type = "S"
  }

  attribute {
    name = "AccountId"
    type = "S"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "LicenseFileHistoryTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.LicenseFileHistory"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Type"
  range_key    = "DateApplied"
  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "Type"
    type = "S"
  }

  attribute {
    name = "DateApplied"
    type = "S"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}

resource "aws_dynamodb_table" "NotificationsTable" {
  name         = "${aws_appconfig_application.AppConfigAgentApplication.id}.Notifications"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Guid"
  range_key    = "Date"

  point_in_time_recovery {
    enabled = aws_ssm_parameter.DynamoPointInTimeRecoveryEnabledParameter.value
  }

  attribute {
    name = "Guid"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "AccountId"
    type = "S"
  }
  attribute {
    name = "Read"
    type = "N"
  }

  global_secondary_index {
    name            = "AccountIdAndDate"
    hash_key        = "AccountId"
    range_key       = "Date"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "ReadAndDate"
    hash_key        = "Read"
    range_key       = "Date"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled     = local.use_dynamo_cmk
    kms_key_arn = var.dynamo_cmk_key_arn
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "DynamoTable" },
    var.custom_resource_tags
  )
}
