# Cloud Storage Security - Terraform Deployment

## Overview

The deployment will create 104 AWS Resources, including:  

* ECS Service
* ECS Task Definition
* IAM Roles for Console and Scanning Engine services
* Amazon Cognito
* DynamoDB
* AWS AppConfig
* SNS
* SSM Paramaters
* Security groups
* Auto Scaling Group
* Load Balancer (conditional)

## Deployment Directions 

Refer to the [deployment guide](DEPLOYMENT.md) for detailed directions.

## File Definitions

### plaform_vars.tf

Contains variables that are required to be provided in the Terraform workspace.

* **vpc**: The VPC ID in which to place the public facing Console
* **cidr**: The CIDR block which is allowed access to the CSS Console (e.g. 0.0.0.0/24 for open access)
* **subnet_a_id**: A subnet ID within the VPC that may be used for ECS tasks for this deployment
* **subnet_b_id**: A second subnet ID within the VPC that may be used for ECS tasks for this deployment. We recommend choosing subnets in different availability zones
* **Email**: The email address to be used for the initial admin account created for the CSS Console
* **ssm_schema_doc_name**: The name of the ssm schema document you created
* **ssm_doc_name**: The name of the ssm document you created

### constant_vars.tf

Contains variables that are configured with a default value and used within the Terraform files.  

Variables that may be desired to be overriden in the Terraform workspace:  

* **agentscanningengine**  
  The scanning engine to use.
  _**Note**: ClamAV is included with no additional charges. Premium engines such as `Sophos` incurr an additional licensing charge per GB (see Marketplace listing for pricing)_
  
  Valid values: `ClamAV`, `Sophos`  
  Default: `ClamAV`  

* **multienginescanningengine**
  Whether or not multiple av engines should be utilized to scan files. If this is enabled, the `agentscanningengine` variable must be set to `Sophos`. When set to `All`, every file will be scanned by both engines. When set to `LargeFiles`, only files larger than 2GB will be scanned with `Sophos`, and 2GB and smaller will be scanned with `ClamAV`.

  Valid values: `Disabled`, `All`, `LargeFiles`
  Default: `Disabled`  

* **ConsoleAutoAssignPublicIp**  
  Whether a public IP should be assigned to the console. If set to false, there will need to be a proxy, nat gateway, or other mechanism in place to allow the Console to reach AWS services. You may configure VPC Endpoints for most AWS services we utilize, but a few do not yet support VPC Endpoints.  

  Valid values: `true`, `false`
  Default: `true`  

* **ecr_account**  
  The AWS Account ID which contains the ECR repositories used for the CSS Console and Agent images. If customized, you must ensure that you have replicated the appropriate images to repositories in the specified account, and the repository names must be `cloudstoragesecurity/console` and `cloudstoragesecurity/agent`

  Valid values: `\d{12}`
  Default: `564477214187`  

* **configure_load_balancer**  
  Whether the Console should be deployed behind a load balancer. Recommended if deploying the Console in private subnets.  
  
  Valid values: `true`, `false`  
  Default: `false`  

* **lb_cert_arn**
  The certificate ARN that should be used for the load balancer. Only required if `configure_load_balancer` is set to `true`.

  Valid values: any valid AWS Certificate ARN
  Default: ``  

* **lb_scheme**
  Whether the Console load balancer should be public (internet-facing) or private (internal).

  Valid values: `internet-facing`, `internal`
  Default: `internet-facing`  

* **InfoOptOut**
  Whether or not you would like to opt out from sending statistics to Cloud Storage Security. This is performed via an api call to an AWS Lambda in CSS' AWS Account. No sensitive information is ever sent to CSS. This should only ever be set to false if you are deploying behind a load balancer, as it would prevent us from registering a friendly DNS address for your deployment. Without a DNS address, the only way to reach the console would be to get the IP address from ECS each time the console task is restarted.  

  Valid values: `true`, `false`
  Default: `false`  

* **service_name**
  A prefix to place on resources that this Terraform template creates. May be overriden if there is an organizational standard for resource name prefixes that needs to be followed

  Value values: any string, but should be short to avoid possibly attempting to create resources with names that exceed the max allowed length
  Default: `CloudStorageSec`  

* **Username**
  The username to be used for the initial user created for accessing the CSS Console

  Valid values: `[A-Za-z0-9-_.@]{3,128}`
  Default: `admin`

### aws.tf

The AWS provider configuration file. This file additionally contains variables that must be set for deployment.

* **aws_account**  
  The aws account id the console will be deployed into

* **aws_region**  
  The aws region to deploy into

### iam.main.tf

This file contains terraform code for all the IAM roles and IAM policies.

### outputs.tf

This contains the details about the output that will be provided after deployment.

### sns.tf

This file has terraform code for SNS and SNS Policy.

### ssm_main.tf

This file contains all SSM Parameters that will be created as part of deployment.

### sg_main.tf

This file contains terraform script for creating security groups.

### locals.tf

Local file is used for storing some variables used internally within terraform.

### ecs_service.tf

This has terraform script for creating ecs service, load balancer, listener and target group.

### ecs_task_definition.tf

It contains terraform script for creating task definition.

### dynamodb.tf

This file has dynamo db terraform script.

### cognito.tf

This file contains terraform configuration for all cognito resources.

### autoscaling.tf

It has all the code related to autoscaling group.

### appagentconfig.tf

This file contains application config code and its dependencies.
