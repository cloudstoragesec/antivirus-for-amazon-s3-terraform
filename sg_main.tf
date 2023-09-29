resource "aws_security_group" "ContainerSecurityGroup" {
  count       = var.configure_load_balancer ? 0 : 1
  description = "${var.service_name}ConsoleSecurityGroup-${aws_appconfig_application.AppConfigAgentApplication.id}"
  vpc_id      = var.vpc

  ingress {
    description = "CloudStorageSec Console port 80 ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }
  ingress {
    description = "CloudStorageSec Console port 443 ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "CloudStorageSec Console default egress to internet"
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "SecurityGroup" },
    var.custom_resource_tags
  )
}

resource "aws_security_group" "ContainerSecurityGroupWithLB" {
  count       = var.configure_load_balancer ? 1 : 0
  description = "${var.service_name}LBSecurityGroup-${aws_appconfig_application.AppConfigAgentApplication.id}"
  vpc_id      = var.vpc

  ingress {
    description     = "CloudStorageSec Console port 80 ingress"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.LoadBalancerSecurityGroup[0].id}"]
  }
  ingress {
    description     = "CloudStorageSec Console port 443 ingress"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.LoadBalancerSecurityGroup[0].id}"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "CloudStorageSec Console default egress to internet"
  }

  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "SecurityGroup" },
    var.custom_resource_tags
  )
}

resource "aws_security_group" "LoadBalancerSecurityGroup" {
  count       = var.configure_load_balancer ? 1 : 0
  description = "${var.service_name}LBSecurityGroup-${aws_appconfig_application.AppConfigAgentApplication.id}"
  vpc_id      = var.vpc

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "CloudStorageSec Console default egress to internet"
  }
  tags = merge({ (join("-", ["${var.service_name}", "${aws_appconfig_application.AppConfigAgentApplication.id}"])) = "SecurityGroup" },
    var.custom_resource_tags
  )
}

