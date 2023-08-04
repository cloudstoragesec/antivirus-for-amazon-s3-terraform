variable "service_name" {
    description = "Name of Service"
    type = string
    default       = "CloudStorageSec"
}


variable "parameter_prefix" {
    description = "Prefix for SSM Parameters"
    type = string
    default       = "CloudStorageSecConsole"
}

variable "quarantine_bucket_prefix" {
    description = "Prefix for the quarantine bucket"
    type = string
    default       = "cloudstoragesecquarantine"
}

variable "lb_scheme" {
    description = "Should the load balancer be internet facing or internal only"
    type = string
    default       = "internet-facing"
}

variable "configure_load_balancer" {
    description = "Whether or not to configure a load balancer in the service. Mark false if there is no LB, mark true if LB is required"
    type = string
    default       = "false"
}

variable "task_network_mode" {
    description = "the network mode- please leave it as awsvpc or everything will break"
    type = string
    default = "awsvpc"
}

variable "container_image" {
    description = "container image"
    type = string
    default = "${var.ecr_account}.dkr.ecr.us-east-1.amazonaws.com/cloudstoragesecurity/console:v6.04.006"
}

variable "InfoOptOut" {
    description = "Would you like to opt-out from sending information about your deployment? Selecting Yes will cause custom DNS registration and trial eligiblity checks to not work. Given this, you must use your own Load Balancer in order to opt-out. If you opt-out and would still like a trial, please contact support@cloudstoragesec.com."
    type = string
    default = "false"
}


variable "desired_count" {
    description = "Number of task instances to run. -1 means the same number as availability zones being used"
    type = string
    default = "1"
}

variable "deployment_maximum_percent" {
    description = "Maximum number to run"
    type = string
    default = "200"
}

variable "deployment_minimum_healthy_percent" {
    description = "Minimum health"
    type = string
    default = "100"
}



variable "ecs_platform_version" {
    description = "the platform version to use"
    type = string
    default = "1.4.0"
}

variable "target_protocol" {
    description = "the protocol to be used to communicate with target instances"
    type = string
    default = "HTTPS"
}


variable "tcp_port" {
    description = "the port to be used for target group"
    type = string
    default = "443"
}

variable "hc_interval" {
    description = "target group health check timeinterval"
    type = string
    default = "300"
}


variable "hc_timeout" {
    description = "target group health check timeout"
    type = string
    default = "120"
}


variable "hc_port" {
    description = "target group health check port"
    type = string
    default = "443"
}

variable "hc_path" {
    description = "target group health check path"
    type = string
    default = "/Account/SignIn"
}


variable "hosted_zone_name" {
    description = "Enter the hosted zone domain name for adding an entry to Route53. Only needed if registering dns in Route53."
    type = string
    default = "domain-for-your-ssl-cert.com"
}

variable "hosted_zone_id" {
    description = "Enter the hosted zone ID for adding an entry to Route53. Only needed if registering dns in Route53 (Optional, only needed if you have multiple zones with the same name)."
    type = string
    default = "ZXXXXDEFAULTXXXXXXXXX"
}


variable "hosted_sub_domain" {
    description = "Enter the subdomain for adding an entry to Route53. Only needed if registering dns in Route53."
    type = string
    default = "subdomain"
}

variable "attribute_list" {
    description = "list of attributes"
    type = list
    default = []
}

variable "UserName" {
    description = "Initial user name for the Console management website"
    type = string
    default = "admin"
}

variable "agentscanningengine" {
    description = "Choose the engine that should be used to scan files (See Marketplace listing for pricing differences)"
    type = string
    default = "ClamAV"
}

variable "multienginescanningengine" {
    description = "Choose if you want to use multiple engines to scan files. All will scan every file with both engines, LargeFiles will scan files larger than 2GB with Sophos. Premium Engine pricing applies."
    type = string
    default = "Disabled"
}


variable "ApiRequestScalingPolicyPrefix" {
    description = "Prefix for the AutoScaling policy for the API Service."
    type = string
    default = "ApiServiceRequestScaling"
}

variable "ConsoleAutoAssignPublicIp" {
    description = "Should a public IP be assigned to the Console? (WARNING: do not set to disabled unless you have configured your AWS VPC in a manner that would still allow access to the console.)"
    type = string
    default = "true"
}


variable "tags_custom" {
    description = "Customized Tags Key Name"
    type = string
    default       = "CloudStorageSec"
}


variable "ecr_account" {
    description = "If you would like to host the container images yourself in ECR, enter the AWS account ID here. Ensure you have copied the images to your repositories. Repository names are required to be cloudstoragesecurity/console and cloudstoragesecurity/agent."
    type = string
    default = "564477214187"
}


