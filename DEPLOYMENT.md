# Cloud Storage Security - Terraform Deployment Directions

## Overview

This document will assist in initial setup and deployment of the CSS product using Terraform.

The state of the provided templates may not be current with the CloudFormation templates which are the primary recommended deployment method.

## Pre-Requisites

### Subscribe to AWS Marketplace Listing

In order to run the product, you must be subscribed to one of Cloud Storage Security's listings in AWS Marketplace.

Our primary listing may be found at the link below. Click `Continue to Subscribe`, and continue until you reach the deployment step. This process will be run instead of the CloudFormation deployment that is described in the listing.  

[Antivirus for Amazon S3 - PAYG with 30 DAY FREE TRIAL](https://aws.amazon.com/marketplace/pp/prodview-q7oc4shdnpc4w)

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
* **cidr**: The CIDR block which is allowed access to the CSS Console (e.g. 0.0.0.0/24 for open access)
* **subnet_a_id**: A subnet ID within the VPC that may be used for ECS tasks for this deployment
* **subnet_b_id**: A second subnet ID within the VPC that may be used for ECS tasks for this deployment. We recommend choosing subnets in different availability zones
* **email**: The email address to be used for the initial admin account created for the CSS Console
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
  * `email`
  * `aws_account`
  * `aws_region`
* All of the above **except** `email` and `aws_account` may be marked as Sensitive, if desired
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
  * **username** the username for the created user
 
 ## Performing Upgrades

 _**Note**: when deploying the CSS product with CloudFormation templates, you may upgrade the Console directly via the CSS Console. This is not possible with the Terraform deployment method. However, Agent updates will still be applied from within the Console_

 * When Cloud Storage Security publishes an update to this repository, you may sync your fork to receive the changes
 * This should trigger the creation of a new plan in your workspace
 * On the `Runs` page in your Terraform workspace, click on the initiated run
 * Once the run is marked as `Planned and finished`, you may scroll down and click `Confirm & Apply` to apply changes to your deployment
