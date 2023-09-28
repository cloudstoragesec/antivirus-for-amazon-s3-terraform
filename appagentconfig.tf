
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

###
# ApplicationConfiguration documents are not currently supported by Terraform.
# Creation needs to be manually performed as part of the pre-requisite step.
# See: https://github.com/hashicorp/terraform-provider-aws/issues/31505
###

# resource "aws_ssm_document" "AppConfigDocumentSchema" {
#   name          = "${var.service_name}Config-Schema-${aws_appconfig_application.AppConfigAgentApplication.id}"
#   document_type = "ApplicationConfigurationSchema"
#   document_format = "JSON"

#   content = <<DOC
#  {
#    "$schema":"http://json-schema.org/draft-07/schema#","description":"Configuration for CloudStorageScan","type":"object","required":["objectTagKeys","quarantine","scanList","skipList","classifyList","classifySkipList","scanTaggingEnabled","scanTagsExcluded","classificationTaggingEnabled","classificationTagsExcluded"],"properties":{"scanTaggingEnabled":{"type":"boolean","description":"Indicates whether tags should be added to the scanned objects."},"scanTagsExcluded":{"type":"array","description":"Scan tags to not be added to scanned objects","items":{"type":"string"},"uniqueItems":true,"additionalProperties":false},"classificationTaggingEnabled":{"type":"boolean","description":"Indicates whether tags should be added to the classified objects."},"classificationTagsExcluded":{"type":"array","description":"Classification tags to not be added to classified objects","items":{"type":"string"},"uniqueItems":true,"additionalProperties":false},"objectTagKeys":{"type":"object","required":["result","dateScanned","virusName","virusUploadedBy","errorMessage","classificationResult","dateClassified","classificationMatches","classificationErrorMessage"],"properties":{"result":{"type":"string","description":"The tag key for scan results."},"dateScanned":{"type":"string","description":"The tag key for the scan date."},"virusName":{"type":"string","description":"The tag key for the virus name."},"virusUploadedBy":{"type":"string","description":"The tag key for who uploaded the virus."},"errorMessage":{"type":"string","description":"The tag key for the error message."},"classificationResult":{"type":"string","description":"The tag key for classification results."},"dateClassified":{"type":"string","description":"The tag key for the classification date."},"classificationMatches":{"type":"string","description":"The tag key for the list of classification matches found."},"classificationErrorMessage":{"type":"string","description":"The tag key for the classification error message."}}},"quarantine":{"type":"object","required":["action","moveBucketPrefix"],"properties":{"action":{"type":"string","pattern":"Keep|Move|Delete","description":"Action to take on an object upon a virus being detected."},"moveBucketPrefix":{"type":"string","description":"Bucket to move infected objects to."}}},"scanList":{"type":"object","patternProperties":{"^[a-zA-Z]+$":{"type":"array","items":{"type":"string"},"additionalProperties":false}}},"skipList":{"type":"object","patternProperties":{"^[a-zA-Z]+$":{"type":"array","items":{"type":"string"},"additionalProperties":false}}},"classifyList":{"type":"object","patternProperties":{"^[a-zA-Z]+$":{"type":"array","items":{"type":"string"},"additionalProperties":false}}},"classifySkipList":{"type":"object","patternProperties":{"^[a-zA-Z]+$":{"type":"array","items":{"type":"string"},"additionalProperties":false}}}},"additionalProperties":false}
# DOC

#   tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConfigSchema"}

# }

# resource "aws_ssm_document" "AppConfigDocument" {
#   name          = "${var.service_name}Config-Doc-${aws_appconfig_application.AppConfigAgentApplication.id}"
#   document_type = "ApplicationConfiguration"
#   document_format = "JSON"
#
#   requires {
#     name = "${aws_ssm_document.AppConfigDocumentSchema.name}"
#     version = "$LATEST"
#   }
#
#   content = <<DOC
# { 
#   "scanTaggingEnabled":true,"scanTagsExcluded":[],"classificationTaggingEnabled":true,"classificationTagsExcluded":[],"objectTagKeys":{"result":"scan-result","dateScanned":"date-scanned","virusName":"virus-name","virusUploadedBy":"uploaded-by","errorMessage":"message","classificationResult":"classification-result","dateClassified":"date-classified","classificationMatches":"classification-matches","classificationErrorMessage":"classification-message"},
#   "quarantine":{
#     "action":"Move",
#     "moveBucketPrefix":"${var.quarantine_bucket_prefix} ${aws_appconfig_application.AppConfigAgentApplication.name}"},
#     "scanList":{},
#     "skipList":{},
#     "classifyList":{},
#     "classifySkipList":{}
# }
#   DOC
#    tags = {(join("-",["${var.service_name}","${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "ConfigDoc"}
# }

resource "aws_appconfig_configuration_profile" "AppConfigProfile" {
  application_id = aws_appconfig_application.AppConfigAgentApplication.id
  description    = "AppConfig profile for CloudStorageSec Agents"
  name           = "${var.service_name}Config-Profile-${aws_appconfig_application.AppConfigAgentApplication.id}"
  location_uri   = "ssm-document://${local.ssm_doc_name}"
  # After Terraform supports `ApplicationConfiguration` docs, the `location_uri` will be the below
  # location_uri   = "ssm-document://${aws_ssm_document.AppConfigDocument.name}" 
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
