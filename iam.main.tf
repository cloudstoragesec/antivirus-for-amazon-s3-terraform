
resource "aws_iam_role" "AppConfigAgentConfigurationDocumentRole" {
  name = "AppConfigAgentConfigurationDocumentRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "appconfig.amazonaws.com"
        }
      },
    ]
  })
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "AppConfigDocumentRole" }
}

resource "aws_iam_role_policy" "AppConfigAgentConfigurationDocumentPolicy" {
  name = "AppConfigAgentConfigurationDocumentPolicy-${aws_appconfig_application.AppConfigAgentApplication.id}"
  role = aws_iam_role.AppConfigAgentConfigurationDocumentRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["ssm:GetDocument"],
        Resource = [
          "arn:aws:ssm:*:*:document/${local.ssm_doc_name}"
        ],
        Effect = "Allow"
      },
    ]
  })
}

resource "aws_iam_role" "UserPoolSnsRole" {
  name = "${var.service_name}UserPoolRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "cognito-idp.amazonaws.com"
        }
      },
    ]
  })
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "UserPoolSnsRole" }
}

resource "aws_iam_role_policy" "UserPoolSnsPolicy" {
  name = "${var.service_name}UserPoolPolicy-${aws_appconfig_application.AppConfigAgentApplication.id}"
  role = aws_iam_role.UserPoolSnsRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sns:publish"
        Effect   = "Allow"
        Sid      = ""
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ConsoleTaskRole" {
  name        = "${var.service_name}ConsoleRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  description = "Console ECS Task IAM Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConsoleTaskRole" }
}

resource "aws_iam_role_policy" "ConsoleTaskPolicy" {
  name = "${var.service_name}ConsolePolicy-${aws_appconfig_application.AppConfigAgentApplication.id}"
  role = aws_iam_role.ConsoleTaskRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DeleteLargeFileScanningVolumes${aws_appconfig_application.AppConfigAgentApplication.id}"
        Effect = "Allow"
        Condition = {
          StringEquals = {
            "ec2:ResourceTag/CloudStorageSecExtraLargeFileScanning" = "ExtraLargeFileScanning"
          }
        }
        Action = [
          "ec2:DeleteVolume",
          "ec2:TerminateInstances"
        ]
        Resource = "arn:aws:ec2:*:*:*"
      },
      {
        Action = [
          "acm:DescribeCertificate",
          "acm:RequestCertificate",
          "application-autoscaling:*ScalableTarget*",
          "application-autoscaling:PutScalingPolicy",
          "aws-marketplace:MeterUsage",
          "cloudformation:GetTemplateSummary",
          "cloudwatch:GetMetricStatistics",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeNetwork*",
          "ec2:DescribeRegions",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVolumes",
          "ec2:DescribeVpcs",
          "ec2:CreateSnapshot",
          "ec2:DeleteSnapshot",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeSnapshots",
          "ecs:CreateCluster",
          "ecs:*TaskDefinition*",
          "ecs:ListTasks",
          "ecs:RunTask",
          "workdocs:*Document*",
          "workdocs:*Labels",
          "workdocs:*Metadata",
          "workdocs:*NotificationSubscription"
        ]
        Effect   = "Allow"
        Sid      = "AllResources${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "*"
      },
      {
        Action = [
          "ec2:*SecurityGroup*",
          "ec2:*Tags",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "ec2:CreateVolume",
          "ec2:DeleteVolume",
          "logs:CreateLogStream",
          "logs:DescribeLog*",
          "logs:FilterLogEvents",
          "logs:GetLog*",
          "logs:GetQueryResults",
          "logs:PutLogEvents",
          "logs:*Query",
          "s3:CreateBucket",
          "s3:GetBucket*",
          "s3:Get*Configuration",
          "s3:GetObject*",
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:PutBucket*",
          "s3:PutObject*",
          "s3:Put*Configuration",
          "elasticfilesystem:CreateTags",
          "elasticfilesystem:CreateMountTarget",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets",
          "elasticfilesystem:DescribeMountTargetSecurityGroups",
          "elasticfilesystem:DescribeTags",
          "elasticfilesystem:TagResource",
          "elasticfilesystem:UntagResource",
          "elasticfilesystem:ListTagsForResource",
          "sns:ListSubscriptions*",
          "sns:ListTopics",
          "sns:Subscribe",
          "sns:Unsubscribe",
          "sqs:ListQueues"
        ]
        Effect = "Allow"
        Sid    = "AllResourcesInService${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = [
          "arn:aws:cloudwatch:*:*:alarm:*",
          "arn:aws:ec2:*::image/*",
          "arn:aws:ec2:*::volume/*",
          "arn:aws:ec2:*:*:*",
          "arn:aws:logs:*:*:*",
          "arn:aws:s3:::*",
          "arn:aws:elasticfilesystem:*:*:file-system",
          "arn:aws:elasticfilesystem:*:*:file-system/*",
          "arn:aws:sns:*:*:*",
          "arn:aws:sqs:*:*:*"
        ]
      },
      {
        Action = [
          "appconfig:*Profile*",
          "appconfig:*Deployment",
          "appconfig:*agResource",
          "appconfig:UpdateDeploymentStrategy",
          "appconfig:UpdateApplication",
          "appconfig:UpdateEnvironment",
          "cloudformation:DescribeStacks",
          "cloudformation:GetTemplateSummary",
          "cloudformation:UpdateStack",
          "cloudwatch:DeleteAlarms",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:*agResource",
          "cognito-idp:*",
          "dynamodb:BatchWriteItem",
          "dynamodb:CreateTable",
          "dynamodb:DeleteItem",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:ListTagsOfResource",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:*agResource",
          "dynamodb:UpdateContinuousBackups",
          "dynamodb:UpdateItem",
          "dynamodb:UpdateTable",
          "ecr:ListImages",
          "ecs:CreateService",
          "ecs:DeleteCluster",
          "ecs:DeleteService",
          "ecs:Describe*",
          "ecs:ListContainerInstances",
          "ecs:ListTagsForResource",
          "ecs:StopTask",
          "ecs:*agResource",
          "ecs:UpdateService",
          "events:*Rule*",
          "events:*Resource",
          "events:*EventBus",
          "events:*Targets",
          "events:*Permission",
          "events:*Bus",
          "iam:*InstanceProfile",
          "iam:*RolePolicy",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:GetRole",
          "iam:PassRole",
          "iam:*agRole",
          "s3:PutEncryptionConfiguration",
          "s3:PutLifecycleConfiguration",
          "s3:DeleteBucket*",
          "s3:DeleteObject*",
          "securityhub:*Findings*",
          "sns:AddPermission",
          "sns:*Topic",
          "sns:*Attributes",
          "sns:ListSubscriptionsByTopic",
          "sns:Publish",
          "sns:*agResource",
          "sqs:*Queue*",
          "sqs:*Message",
          "sqs:*Attributes",
          "ssm:*Tags*",
          "ssm:*Document*",
          "ssm:*Parameter*"
        ]
        Effect = "Allow"
        Sid    = "RestrictedResources${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = [
          "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.AgentTaskRole.name}",
          "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.AppConfigAgentConfigurationDocumentRole.name}",
          "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.ConsoleTaskRole.name}",
          "arn:aws:iam::*:role/${aws_iam_role.Ec2ContainerRole.name}",
          "arn:aws:iam::*:instance-profile/${aws_iam_role.Ec2ContainerRole.name}",
          "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.ExecutionRole.name}",
          "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.UserPoolSnsRole.name}",
          local.create_event_bridge_role ? "arn:aws:iam::*:role/${aws_iam_role.EventBridgeRole[0].name}" : var.event_bridge_role_name,
          "arn:aws:appconfig:*:*:application/${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:appconfig:*:*:application/${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:appconfig:*:*:deploymentstrategy/${aws_appconfig_deployment_strategy.AppConfigAgentDeploymentStrategy.id}",
          "arn:aws:cognito-idp:*:*:userpool/${aws_cognito_user_pool.UserPool.id}",
          "arn:aws:cloudwatch:*:*:alarm:*${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:cloudwatch:*:*:alarm:TargetTracking-service/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:dynamodb:${var.aws_region}:*:table/${aws_appconfig_application.AppConfigAgentApplication.id}*",
          "arn:aws:ecs:*:*:service/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:ecs:*:*:cluster/*${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:ecs:*:*:task/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:ecs:*:*:task-definition/*${aws_appconfig_application.AppConfigAgentApplication.id}*",
          "arn:aws:events:*:*:*/*${aws_appconfig_application.AppConfigAgentApplication.id}*",
          "arn:aws:events:*:*:*/default",
          "arn:aws:events:*:*:rule/*",
          "arn:aws:iam::*:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService",
          "arn:aws:s3:::*${aws_appconfig_application.AppConfigAgentApplication.id}-*",
          "arn:aws:s3:::*${aws_appconfig_application.AppConfigAgentApplication.id}-*/*",
          "arn:aws:sns:*:*:*${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:sqs:*:*:*${aws_appconfig_application.AppConfigAgentApplication.id}*",
          "arn:aws:ssm:*:*:parameter/aws/service/ecs/optimized-ami/amazon-linux*/recommended/image_id",
          "arn:aws:ssm:*:*:document/${local.ssm_doc_name}",
          "arn:aws:ssm:*:*:document/${local.ssm_schema_doc_name}",
          "arn:aws:ssm:*:*:parameter/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:ssm:*:*:parameter/*${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:ecr:${var.aws_region}:${var.ecr_account}:repository/cloudstoragesecurity/*",
          "arn:aws:securityhub:${var.aws_region}::product/cloud-storage-security/antivirus-for-amazon-s3",
          "arn:aws:securityhub:${var.aws_region}:*:product-subscription/cloud-storage-security/antivirus-for-amazon-s3",
          "arn:aws:securityhub:${var.aws_region}:*:hub/default"
        ]
      },
      {
        Effect = "Allow"
        Sid    = "Logs${aws_appconfig_application.AppConfigAgentApplication.id}"
        Action = [
          "logs:CreateLogGroup",
          "logs:DeleteLogGroup",
          "logs:PutRetentionPolicy",
          "logs:*agLogGroup"
        ]
        Resource = [
          "arn:aws:logs:*:*:log-group:CloudStorageSecurity.*",
          "arn:aws:logs:*:*:log-group:CloudStorageSecurity.*:*"
        ]
      },
      {
        Action   = "sts:AssumeRole"
        Effect   = "Allow"
        Sid      = "CrossAccount${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "arn:aws:iam::*:role/*${aws_appconfig_application.AppConfigAgentApplication.id}"
      },
      {
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey"
        ]
        Effect   = "Allow"
        Sid      = "KmsConsole${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = local.blanket_kms_access ? "*" : "arn:aws:kms:::key/no-blanket-kms-access"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "s3.*.amazonaws.com"
          }
        }
      },
      {
        Sid      = "PutMetricData${aws_appconfig_application.AppConfigAgentApplication.id}"
        Effect   = "Allow"
        Action   = "cloudwatch:PutMetricData"
        Resource = "*"
        Condition = {
          StringEquals = {
            "cloudwatch:Namespace" = "AWS/ECS"
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "ConsoleTaskPolicyApiLb" {
  name = "${var.service_name}ConsolePolicy-${aws_appconfig_application.AppConfigAgentApplication.id}-ApiLb"
  role = aws_iam_role.ConsoleTaskRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeAccountAttributes",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeTargetGroups"
        ]
        Effect   = "Allow"
        Sid      = "AllResources${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "*"
      },
      {
        Action = [
          "elasticloadbalancing:Create*",
          "elasticloadbalancing:Delete*",
          "elasticloadbalancing:Modify*",
          "elasticloadbalancing:*Tags",
          "elasticloadbalancing:SetSubnets",
          "iam:CreateServiceLinkedRole"
        ]
        Effect = "Allow"
        Sid    = "RestrictedResources${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = [
          "arn:aws:elasticloadbalancing:*:*:listener/*/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/*/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:elasticloadbalancing:*:*:targetgroup/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:iam::*:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy" "ConsoleTaskPolicyAwsLicensing" {
  name = "${var.service_name}ConsolePolicy-${aws_appconfig_application.AppConfigAgentApplication.id}-AwsLicensing"
  role = aws_iam_role.ConsoleTaskRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "license-manager:CheckoutLicense",
          "license-manager:ListReceivedLicenses"
        ]
        Effect   = "Allow"
        Sid      = "AllResources${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "CloudTrailLakePolicy" {
  name = "${var.service_name}ConsolePolicy-${aws_appconfig_application.AppConfigAgentApplication.id}-CloudTrailLake"
  role = aws_iam_role.ConsoleTaskRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cloudtrail:*DataStore*",
          "cloudtrail:*Quer*",
          "cloudtrail:*Channel*",
          "cloudtrail-data:*Audit*",
          "iam:ListRoles",
          "iam:GetRolePolicy",
          "iam:GetUser"
        ]
        Effect   = "Allow"
        Sid      = "CloudTrail"
        Resource = "*"
      },
      {
        Action = [
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Sid      = "PassRole"
        Resource = "*"
        Condition = {
          StringEquals = { "iam:PassedToService" = "cloudtrail.amazonaws.com" }
        }

      },
    ]
  })
}

resource "aws_iam_role" "AgentTaskRole" {
  name = "${var.service_name}AgentRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "AgentTaskRole" }
}

resource "aws_iam_role_policy" "AgentTaskPolicy" {
  name = "${var.service_name}AgentPolicy-${aws_appconfig_application.AppConfigAgentApplication.id}"
  role = aws_iam_role.AgentTaskRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "aws-marketplace:MeterUsage",
          "ec2:DescribeVpcs",
          "workdocs:*Document*",
          "workdocs:*Labels",
          "workdocs:*Metadata"
        ]
        Effect   = "Allow"
        Sid      = "AllResources${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "*"
      },
      {
        Action = [
          "appconfig:ListApplications",
          "appconfig:ListDeploymentStrategies",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation",
          "s3:GetObject*",
          "s3:GetEncryptionConfiguration",
          "s3:ListBucket",
          "s3:PutObject*",
          "s3:PutEncryptionConfiguration",
          "ssm:ListDocuments"
        ]
        Effect = "Allow"
        Sid    = "AllResourcesInService${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:appconfig:*:*:*",
          "arn:aws:ssm:*:*:*"
        ]
      },
      {
        Action = [
          "appconfig:GetApplication",
          "appconfig:StartConfigurationSession",
          "appconfig:GetLatestConfiguration",
          "appconfig:GetConfiguration*",
          "appconfig:GetDeploymentStrategy",
          "appconfig:GetEnvironment",
          "appconfig:ListConfigurationProfiles",
          "appconfig:ListDeployments",
          "appconfig:ListEnvironments",
          "cognito-idp:*",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:PutLogEvents",
          "securityhub:BatchImportFindings",
          "sns:ConfirmSubscription",
          "sns:Publish",
          "sqs:*Message",
          "sqs:GetQueueAttributes",
          "ssm:GetDocument",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Effect = "Allow"
        Sid    = "RestrictedResources${aws_appconfig_application.AppConfigAgentApplication.id}"
        #Add list
        Resource = [
          "arn:aws:appconfig:*:*:application/${aws_appconfig_application.AppConfigAgentApplication.id}/configurationprofile/*",
          "arn:aws:appconfig:*:*:application/${aws_appconfig_application.AppConfigAgentApplication.id}/environment/${aws_appconfig_environment.AppConfigAgentEnvironment.environment_id}",
          "arn:aws:appconfig:*:*:application/${aws_appconfig_application.AppConfigAgentApplication.id}/environment/${aws_appconfig_environment.AppConfigAgentEnvironment.environment_id}/configuration/*",
          "arn:aws:appconfig:*:*:application/${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:appconfig:*:*:deploymentstrategy/${aws_appconfig_deployment_strategy.AppConfigAgentDeploymentStrategy.id}",
          "arn:aws:cognito-idp:*:*:userpool/${aws_cognito_user_pool.UserPool.id}",
          "arn:aws:dynamodb:${var.aws_region}:*:table/${aws_appconfig_application.AppConfigAgentApplication.id}.*",
          "arn:aws:logs:*:*:*",
          "arn:aws:securityhub:${var.aws_region}::product/cloud-storage-security/antivirus-for-amazon-s3",
          "arn:aws:sns:*:*:awsworkdocs*",
          "arn:aws:sns:*:*:*${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:sqs:*:*:*${aws_appconfig_application.AppConfigAgentApplication.id}*",
          "arn:aws:ssm:*:*:document/*${aws_appconfig_application.AppConfigAgentApplication.id}",
          "arn:aws:ssm:*:*:parameter/*${aws_appconfig_application.AppConfigAgentApplication.id}/*",
          "arn:aws:ssm:*:*:parameter/*${aws_appconfig_application.AppConfigAgentApplication.id}"
        ]
      },
      {
        Action   = "logs:CreateLogGroup"
        Effect   = "Allow"
        Sid      = "Logs${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action   = "sts:AssumeRole"
        Effect   = "Allow"
        Sid      = "CrossAccount${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "arn:aws:iam::*:role/*${aws_appconfig_application.AppConfigAgentApplication.id}"
      },
      {
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey"
        ]
        Effect   = "Allow"
        Sid      = "Kms${aws_appconfig_application.AppConfigAgentApplication.id}"
        Resource = "*"
        Condition = {
          StringLike = { "kms:ViaService" = "s3.*.amazonaws.com" }
        }
      },
    ]
  })
}

#This is exec role
resource "aws_iam_role" "ExecutionRole" {
  name = "${var.service_name}ExecutionRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]

  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ExecutionRole" }
}

resource "aws_iam_role" "Ec2ContainerRole" {
  name = "${var.service_name}Ec2ContainerRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"]

  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "Ec2ContainerRole" }
}

resource "aws_iam_role_policy" "Ec2ContainerPolicy" {
  name = "${var.service_name}Ec2ContainerPolicy-${aws_appconfig_application.AppConfigAgentApplication.id}"
  role = aws_iam_role.Ec2ContainerRole.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "TagRestrictedResources"
        Effect = "Allow"
        Condition = {
          StringEquals = {
            "ec2:ResourceTag/CloudStorageSecExtraLargeFileScanning" = "ExtraLargeFileScanning"
          }
        }
        Action = [
          "ec2:DeleteSnapshot",
          "ec2:DeleteVolume",
          "ec2:DescribeVolumeAttribute",
          "ec2:DetachVolume",
          "ec2:ModifySnapshotAttribute",
          "ec2:ModifyVolumeAttribute",
          "ec2:ModifyInstanceAttribute"
        ]
        Resource = [
          "arn:aws:ec2:*:${var.aws_account}:*",
          "arn:aws:ec2:*:${var.aws_account}:volume/*",
          "arn:aws:ec2:*::snapshot/*"
        ]
      },
      {
        Sid    = "TagResources"
        Effect = "Allow"
        Action = [
          "ec2:CreateTags"
        ]
        Resource = [
          "arn:aws:ec2:*:${var.aws_account}:*",
          "arn:aws:ec2:*::image/*",
          "arn:aws:ec2:*::snapshot/*",
          "arn:aws:ec2:*:${var.aws_account}:volume/*"
        ]
      },
      {
        Sid    = "AllResources"
        Effect = "Allow"
        Action = [
          "ec2:AttachVolume",
          "ec2:CopySnapshot",
          "ec2:CreateSnapshot",
          "ec2:CreateVolume",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshotAttribute",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumeStatus"
        ]
        Resource = "*"
      },
      {
        Sid    = "KmsAccess"
        Effect = "Allow"
        Condition = {
          StringLike = {
            "kms:ViaService" = "ec2.*.${data.aws_partition.current.dns_suffix}"
          }
        }
        Action = [
          "kms:CreateGrant"
        ]
        Resource = local.blanket_kms_access ? "*" : "arn:aws:kms:::key/no-blanket-kms-access"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "Ec2ContainerInstanceProfile" {
  name = "${var.service_name}Ec2ContainerRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  role = aws_iam_role.Ec2ContainerRole.name
}

resource "aws_iam_role" "EventBridgeRole" {
  count = local.create_event_bridge_role ? 1 : 0
  name  = "${var.service_name}EventBridgeRole-${aws_appconfig_application.AppConfigAgentApplication.id}"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "EventBridgePolicy" {
  name = "${var.service_name}EventBridgePolicy-${aws_appconfig_application.AppConfigAgentApplication.id}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PutEvents${aws_appconfig_application.AppConfigAgentApplication.id}"
        Effect = "Allow"
        Action = [
          "events:PutEvents"
        ]
        Resource = [
          "arn:aws:events:*:${var.aws_account}:event-bus/*${aws_appconfig_application.AppConfigAgentApplication.id}"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "event_bridge_policy_attach" {
  role       = local.create_event_bridge_role ? aws_iam_role.EventBridgeRole[0].name : var.event_bridge_role_name
  policy_arn = aws_iam_policy.EventBridgePolicy.arn
}