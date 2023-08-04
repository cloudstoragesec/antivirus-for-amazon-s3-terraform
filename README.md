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

## File Definitions

### plaform_vars.tf

This terraform file contains all the varibles that're mandatory and needs to be provided by customer, either a default value has to be provided in the file or has to be added as a terraform variable in terraform console(Refer Instruction Manual).

### constant_vars.tf

This terraform file contains all the other variables that've been used to create resoruces. Every variable are distinct, has a default value that can be changes as per requirement and has a brief description about its usage.

### aws.tf

This is an aws configuration file that has information about provider that is aws version, region,account and terraform version.

### iam.main.tf

This file contains terraform code for all the IAM roles and IAM policies.

### outputs.tf

This contains the details about the putput that will be provided to custome after deployment.

### sns.tf

This file has terraform code for SNS and SNS Policy.

### ssm_main.tf

This file contains all the SSM Parameters that will be created as part of deployment.

### sg_main.tf

This file contains terraform script for creating security groups.

### locals.tf

Local file is used for storing some varibale and using internally within terraform.

### ecs_service.tf

This has terraform script for creating ecs service, load balancer, listener and target group.

### ecs_task_definition.tf

It contains terraform script for creating task definition.

### dynamodb.tf

This file has dynamo db terraform script.

### dns.tf

It has dns configuration but has been commented out foe now. If in use, needs to be updated and deployed.

### cognito.tf

This file contains terraform configuration for all the cognito resources.

### autoscaling.tf

It has all the code related to autoscaling group.

### appagentconfig.tf

This file contains application config code and it's dependencies.

## Deployment Directions 

Refer to the [deployment guide](DEPLOYMENT.md) for detailed directions.
