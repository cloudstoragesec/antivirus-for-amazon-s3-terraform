variable "image_version_console" {
  description = "Console version to Deploy"
  default     = "v7.03.000"
}

variable "image_version_agent" {
  description = "Agent version to Deploy"
  default     = "v7.03.000"
}

variable "service_name" {
  description = "Name of Service"
  type        = string
  default     = "CloudStorageSec"
}

variable "parameter_prefix" {
  description = "Prefix for SSM Parameters"
  type        = string
  default     = "CloudStorageSecConsole"
}

variable "quarantine_bucket_prefix" {
  description = "Prefix for the quarantine bucket"
  type        = string
  default     = "cloudstoragesecquarantine"
}

variable "lb_scheme" {
  description = "Should the load balancer be internet facing or internal only"
  type        = string
  default     = "internet-facing"
}

variable "configure_load_balancer" {
  description = "Whether or not to configure a load balancer in the service. Mark false if there is no LB, mark true if LB is required"
  type        = bool
  default     = false
}

variable "lb_cert_arn" {
  description = "The certificate arn to use for the load balancer. Required if `configure_load_balancer` is true"
  type        = string
  default     = ""
}

variable "task_network_mode" {
  description = "the network mode- please leave it as awsvpc or everything will break"
  type        = string
  default     = "awsvpc"
}

variable "info_opt_out" {
  description = "Would you like to opt-out from sending information about your deployment? Selecting Yes will cause custom DNS registration and trial eligiblity checks to not work. Given this, you must use your own Load Balancer in order to opt-out. If you opt-out and would still like a trial, please contact support@cloudstoragesec.com."
  type        = bool
  default     = false
}

variable "desired_count" {
  description = "Number of task instances to run. -1 means the same number as availability zones being used"
  type        = string
  default     = "1"
}

variable "deployment_maximum_percent" {
  description = "Maximum number to run"
  type        = string
  default     = "200"
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum health"
  type        = string
  default     = "100"
}

variable "ecs_platform_version" {
  description = "the platform version to use"
  type        = string
  default     = "1.4.0"
}

variable "target_protocol" {
  description = "the protocol to be used to communicate with target instances"
  type        = string
  default     = "HTTPS"
}

variable "tcp_port" {
  description = "the port to be used for target group"
  type        = string
  default     = "443"
}

variable "hc_interval" {
  description = "target group health check timeinterval"
  type        = string
  default     = "300"
}

variable "hc_timeout" {
  description = "target group health check timeout"
  type        = string
  default     = "120"
}

variable "hc_port" {
  description = "target group health check port"
  type        = string
  default     = "443"
}

variable "hc_path" {
  description = "target group health check path"
  type        = string
  default     = "/Account/SignIn"
}

variable "username" {
  description = "Initial user name for the Console management website"
  type        = string
  default     = "admin"
}

variable "agent_scanning_engine" {
  description = "Choose the engine that should be used to scan files (See Marketplace listing for pricing differences)"
  type        = string
  default     = "ClamAV"
}

variable "multi_engine_scanning_mode" {
  description = "Choose if you want to use multiple engines to scan files. All will scan every file with both engines, LargeFiles will scan files larger than 2GB with Sophos. Premium Engine pricing applies."
  type        = string
  default     = "Disabled"
}

variable "api_request_scaling_policy_prefix" {
  description = "Prefix for the AutoScaling policy for the API Service."
  type        = string
  default     = "ApiServiceRequestScaling"
}

variable "console_auto_assign_public_Ip" {
  description = "Should a public IP be assigned to the Console? (WARNING: do not set to disabled unless you have configured your AWS VPC in a manner that would still allow access to the console.)"
  type        = string
  default     = "true"
}

variable "ecr_account" {
  description = "If you would like to host the container images yourself in ECR, enter the AWS account ID here. Ensure you have copied the images to your repositories. Repository names are required to be cloudstoragesecurity/console and cloudstoragesecurity/agent."
  type        = string
  default     = "564477214187"
}

variable "product_mode" {
  description = "Initial product mode for this deployment. Do not modify this value."
  type        = string
  default     = "AV"
}

variable "event_bridge_role_arn" {
  description = "Role ARN for AWS Event Bridge execution"
  type        = string
  default     = "Created by TF"
}

variable "event_bridge_role_name" {
  description = "Role name for the AWS AWS Event Bridge execution"
  type        = string
  default     = "Created by TF"
}

variable "agent_auto_assign_public_ip" {
  description = "Should public IPs be assigned to the Agents? (WARNING: do not set to disabled unless you have configured your AWS VPC in a manner that would still allow the agents to reach AWS services over the internet.)"
  type        = string
  default     = "ENABLED"
}

variable "allow_access_to_all_kms_keys" {
  description = "Pick Yes if you would like to give the scanner access to all KMS encrypted buckets"
  type        = string
  default     = "Yes"
}

variable "proxy_host" {
  description = "URL for proxy server"
  type        = string
  default     = "none"
}

variable "proxy_port" {
  description = "Port for proxy server"
  type        = string
  default     = "none"
}

variable "template_variation" {
  description = "Do not modify this value, it is for specialized template use only."
  type        = string
  default     = "default"
}

variable "buckets_to_protect" {
  description = "Enter any pre-existing buckets that you would like to automatically enable event-based protection on. Bucket names must be separated by commas (e.g. bucket1,bucket2,bucket3). Protected buckets can be managed after deployment in the CSS Console."
  type        = string
  default     = ""
}