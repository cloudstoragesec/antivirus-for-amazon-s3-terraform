# Cloud Storage Security - Terraform Deployment Directions

## Overview

This document will assist in initial setup and deployment of the CSS product using Terraform.

The state of the provided templates may not be current with the CloudFormation templates which are the primary recommended deployment method.

## Pre-Requisites

### AWS AppConfig

#### Details

Due to a Terraform limitation, some AppConfig resources will need to be created ahead of time. Provided in the following sections are `aws cli` commands that will create the required resources.

Specifically, Terraform does not yet support [ApplicationConfiguration](https://github.com/hashicorp/terraform-provider-aws/issues/31505) documents.

When the [enhancement](https://github.com/hashicorp/terraform-provider-aws/pull/31506) is accepted, this pre-requisite will be removed, and the resources will be created in terraform.

#### Creation Steps

##### Choose a unique suffix to use for the document names

Decide on a suffix to append to the two document names. This would normally be a 7 character alphanumeric string, but that is not a requirement.  

Save this suffix as an environment variable which will be used in the commands that follow.

```shell
$SSM_DOC_NAME_SUFFIX="abc1234"
```

##### Create the SSM ApplicationConfigurationSchema Document

```shell
aws ssm create-document \
  --name CloudStorageSecConfig-Schema-${SSM_DOC_NAME_SUFFIX} \
  --document-type ApplicationConfigurationSchema \
  --document-format JSON \
  --tags "Key=CloudStorageSec-${SSM_DOC_NAME_SUFFIX},Value=AppConfigSchemaDocument" \
  --content "{\"$schema\":\"http://json-schema.org/draft-07/schema#\",\"description\":\"Configuration for CloudStorageScan\",\"type\":\"object\",\"required\":[\"objectTagKeys\",\"quarantine\",\"scanList\",\"skipList\",\"classifyList\",\"classifySkipList\",\"scanTaggingEnabled\",\"scanTagsExcluded\",\"classificationTaggingEnabled\",\"classificationTagsExcluded\"],\"properties\":{\"scanTaggingEnabled\":{\"type\":\"boolean\",\"description\":\"Indicates whether tags should be added to the scanned objects.\"},\"scanTagsExcluded\":{\"type\":\"array\",\"description\":\"Scan tags to not be added to scanned objects\",\"items\":{\"type\":\"string\"},\"uniqueItems\":true,\"additionalProperties\":false},\"classificationTaggingEnabled\":{\"type\":\"boolean\",\"description\":\"Indicates whether tags should be added to the classified objects.\"},\"classificationTagsExcluded\":{\"type\":\"array\",\"description\":\"Classification tags to not be added to classified objects\",\"items\":{\"type\":\"string\"},\"uniqueItems\":true,\"additionalProperties\":false},\"objectTagKeys\":{\"type\":\"object\",\"required\":[\"result\",\"dateScanned\",\"virusName\",\"virusUploadedBy\",\"errorMessage\",\"classificationResult\",\"dateClassified\",\"classificationMatches\",\"classificationErrorMessage\"],\"properties\":{\"result\":{\"type\":\"string\",\"description\":\"The tag key for scan results.\"},\"dateScanned\":{\"type\":\"string\",\"description\":\"The tag key for the scan date.\"},\"virusName\":{\"type\":\"string\",\"description\":\"The tag key for the virus name.\"},\"virusUploadedBy\":{\"type\":\"string\",\"description\":\"The tag key for who uploaded the virus.\"},\"errorMessage\":{\"type\":\"string\",\"description\":\"The tag key for the error message.\"},\"classificationResult\":{\"type\":\"string\",\"description\":\"The tag key for classification results.\"},\"dateClassified\":{\"type\":\"string\",\"description\":\"The tag key for the classification date.\"},\"classificationMatches\":{\"type\":\"string\",\"description\":\"The tag key for the list of classification matches found.\"},\"classificationErrorMessage\":{\"type\":\"string\",\"description\":\"The tag key for the classification error message.\"}}},\"quarantine\":{\"type\":\"object\",\"required\":[\"action\",\"moveBucketPrefix\"],\"properties\":{\"action\":{\"type\":\"string\",\"pattern\":\"Keep|Move|Delete\",\"description\":\"Action to take on an object upon a virus being detected.\"},\"moveBucketPrefix\":{\"type\":\"string\",\"description\":\"Bucket to move infected objects to.\"}}},\"scanList\":{\"type\":\"object\",\"patternProperties\":{\"^[a-zA-Z]+$\":{\"type\":\"array\",\"items\":{\"type\":\"string\"},\"additionalProperties\":false}}},\"skipList\":{\"type\":\"object\",\"patternProperties\":{\"^[a-zA-Z]+$\":{\"type\":\"array\",\"items\":{\"type\":\"string\"},\"additionalProperties\":false}}},\"classifyList\":{\"type\":\"object\",\"patternProperties\":{\"^[a-zA-Z]+$\":{\"type\":\"array\",\"items\":{\"type\":\"string\"},\"additionalProperties\":false}}},\"classifySkipList\":{\"type\":\"object\",\"patternProperties\":{\"^[a-zA-Z]+$\":{\"type\":\"array\",\"items\":{\"type\":\"string\"},\"additionalProperties\":false}}}},\"additionalProperties\":false}"
```

##### Create the SSM ApplicationConfiguration Document

```shell
aws ssm create-document \
  --name CloudStorageSecConfig-${SSM_DOC_NAME_SUFFIX} \
  --document-type ApplicationConfiguration \
  --document-format JSON \
  --requires "Name=CloudStorageSecConfigSchema-${SSM_DOC_NAME_SUFFIX},Version=\$LATEST" \
  --tags "Key=CloudStorageSec-${SSM_DOC_NAME_SUFFIX},Value=AppConfigDocument" \
  --content "{\"scanTaggingEnabled\": true,\"scanTagsExcluded\": [],\"classificationTaggingEnabled\": true,\"classificationTagsExcluded\": [],\"objectTagKeys\": {\"result\": \"scan-result\",\"dateScanned\": \"date-scanned\",\"virusName\": \"virus-name\",\"virusUploadedBy\": \"uploaded-by\",\"errorMessage\": \"message\",\"classificationResult\": \"classification-result\",\"dateClassified\": \"date-classified\",\"classificationMatches\": \"classification-matches\",\"classificationErrorMessage\": \"classification-message\"},\"quarantine\": {\"action\": \"Move\",\"moveBucketPrefix\": \"cloudstoragesecquarantine-${SSM_DOC_NAME_SUFFIX}\"},\"scanList\": {},\"skipList\": {},\"classifyList\": {},\"classifySkipList\": {}}"
```

### GitHub Repository

_**Note**: This deployment guide assumes you will utilize a GitHub repository to synchronize deployments. You may use other options as necessary._

* Create a fork of this repository into your organization or personal account

### AWS Credentials

* If your organization has a required method of authenticating with AWS, you may utilize that method
  * The `aws` provider in [aws.tf](aws.tf) does not directly specify any credentials

#### Recommended Approach

We recommend utilizing dynamic credentials and OIDC with AWS in order to allow Terraform to assume a role and manage the resources for this deployment.

The role that is created for this purpose must have sufficient priviledges to create and manage the resources for this deployment.

You can find instructions for configuring this approach [here](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration).

#### Alternate Approach (NOT RECOMMENDED)

It is possible to simply utilize AWS IAM Credentials for authorizing Terraform.

Using an IAM account that has sufficient priviledges to create and manage the resources for this deployment, generate new IAM credentials. Save the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values for later.

### Deployment Variables

There are input parameters which are required to be set for deployment to be successful.

Gather the appropriate values for the following, and make note of them for later.

* **vpc**: The VPC ID in which to place the public facing Console
* **subnet_a_id**: A subnet ID within the VPC that may be used for ECS tasks for this deployment
* **subnet_b_id**: A second subnet ID within the VPC that may be used for ECS tasks for this deployment. We recommend choosing subnets in different availability zones
* **Email**: The email address to be used for the initial admin account created for the CSS Console
* **ssm_schema_doc_name**: The name of the ssm schema document you created
* **ssm_doc_name**: The name of the ssm document you created
* **aws_account**: The aws account id the console will be deployed into
* **aws_region**: The aws region to deploy into

### Create a new workspace in Terraform Cloud

_**Note**: these are simple directions for a new workspace setup, you may utilize your own existing processes your organization has in place_

* Login to [Terraform Cloud](https://app.terraform.io/app/)
* Navigate to `Projects and Workspaces`
* Click `New -> Workspace`
* Choose `Version Control Workflow`
* Select `GitHub`
* Follow the prompts to authorize Terraform Cloud to your GitHub account, and select the fork of this GitHub repository
* Choose `Manual Apply`, `Always Trigger Runs`, `Automatic speculative plans`, and click `Update VCS Settings`

### Configure Workspace Variables

* Open the workspace you created
* Click `Configure Variables`
* Click `Add Variable`, and add the following as `Terraform variables`, using the values from the previous step.
  * `vpc`
  * `subnet_a_id`
  * `subnet_b_id`
  * `Email`
  * `ssm_schema_doc_name`
  * `ssm_doc_name`
  * `aws_account`
  * `aws_region`
* All of the above **except** `Email` and `aws_account` may be marked as Sensitive, if desired
* Add `Environment Variables` for AWS Authorization
  * When using the recommended OIDC approach
    * `TFC_AWS_PROVIDER_AUTH = true`
    * `TFC_AWS_RUN_ROLE_ARN = <role_arn_to_assume>`
    * See other optional env vars in the guide linked above
  * When using IAM Credentials, enter the values saved earlier
    * `AWS_ACCESS_KEY_ID`
    * `AWS_SECRET_ACCESS_KEY`

## Deployment

* Open the workspace in [Terraform Cloud](https://app.terraform.io/app/)
* Click `Actions -> Start new run`
* Choose `Plan and apply (standard)`, and `Start run`
* Once the plan is finished, scroll down, and click `Confirm & Apply`
* When deployment is complete, you will notice several outputs that you may want to make note of. You will have received an email with your temporary password
  * **ConsoleWebAddress**: the address of the deployed CSS Console
  * **Username** the username for the created user
 
 ## Performing Upgrades

 _**Note**: when deploying the CSS product with CloudFormation templates, you may upgrade the Console directly via the CSS Console. This is not possible with the Terraform deployment method. However, Agent updates will still be applied from within the Console_

 * When Cloud Storage Security publishes an update to this repository, you may sync your fork to receive the changes
 * This should trigger the creation of a new plan in your workspace
 * On the `Runs` page in your Terraform workspace, click on the initiated run
 * Once the run is marked as `Planned and finished`, you may scroll down and click `Confirm & Apply` to apply changes to your deployment
