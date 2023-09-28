
resource "random_id" "stack" {
  byte_length = 4
}

resource "aws_appconfig_application" "AppConfigAgentApplication" {
  name        = "${var.service_name}-${random_id.stack.hex}"
  description = "AppConfig Application for CloudStorageSec Agents"
  tags        = { (join("-", ["${var.service_name}", "${random_id.stack.hex}"])) = "ConsoleAppConfig" }
}

resource "aws_appconfig_environment" "AppConfigAgentEnvironment" {
  name           = "${var.service_name}Env-${aws_appconfig_application.AppConfigAgentApplication.id}"
  description    = "AppConfig Environment for CloudStorageSec Agents"
  application_id = aws_appconfig_application.AppConfigAgentApplication.id
  tags           = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConfigEnvironment" }
}

resource "aws_appconfig_deployment_strategy" "AppConfigAgentDeploymentStrategy" {
  name                           = "${var.service_name}ConfigDeploy-${aws_appconfig_application.AppConfigAgentApplication.id}"
  description                    = "AppConfig Deployment Strategy for CloudStorageSec Agents"
  deployment_duration_in_minutes = 0
  final_bake_time_in_minutes     = 0
  growth_factor                  = 100
  growth_type                    = "LINEAR"
  replicate_to                   = "NONE"

  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConfigStartegy" }
}

resource "awscc_ssm_document" "AppConfigDocumentSchema" {
  name            = "${var.service_name}Config-Schema-${aws_appconfig_application.AppConfigAgentApplication.id}"
  document_type   = "ApplicationConfigurationSchema"
  document_format = "JSON"
  content         = file("${path.module}/app_config_schema.json")
  tags = [
    {
      key   = (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"]))
      value = "ConfigSchema"
    }
  ]

}

resource "awscc_ssm_document" "AppConfigDocument" {
  name            = "${var.service_name}Config-Doc-${aws_appconfig_application.AppConfigAgentApplication.id}"
  document_type   = "ApplicationConfiguration"
  document_format = "JSON"

  requires = [
    {
      name    = "${awscc_ssm_document.AppConfigDocumentSchema.name}"
      version = "$LATEST"
    }
  ]

  lifecycle {
    ignore_changes = [requires]
  }

  content = templatefile("${path.module}/app_config_doc.json", {
    app_id = aws_appconfig_application.AppConfigAgentApplication.id
  })
  tags = [
    {
      key   = (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"]))
      value = "ConfigDoc"
    }
  ]
}

resource "aws_appconfig_configuration_profile" "AppConfigProfile" {
  application_id     = aws_appconfig_application.AppConfigAgentApplication.id
  description        = "AppConfig profile for CloudStorageSec Agents"
  name               = "${var.service_name}Config-Profile-${aws_appconfig_application.AppConfigAgentApplication.id}"
  location_uri       = "ssm-document://${awscc_ssm_document.AppConfigDocument.name}"
  retrieval_role_arn = aws_iam_role.AppConfigAgentConfigurationDocumentRole.arn
  tags               = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConfigProfile" }
}

resource "aws_appconfig_deployment" "AppConfigAgentDeployment" {
  application_id           = aws_appconfig_application.AppConfigAgentApplication.id
  configuration_profile_id = aws_appconfig_configuration_profile.AppConfigProfile.configuration_profile_id
  configuration_version    = 1
  deployment_strategy_id   = aws_appconfig_deployment_strategy.AppConfigAgentDeploymentStrategy.id
  description              = "AppConfig Deployment for CloudStorageSec Agents"
  environment_id           = aws_appconfig_environment.AppConfigAgentEnvironment.environment_id

  tags = { (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConfigDeployment" }
}
