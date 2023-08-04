# resource "aws_route53_record" "DNSRecord" {
#   zone_id = "${var.hosted_zone_id}"
#   name    = "${var.hosted_sub_domain}.${var.hosted_zone_name}."
#   type    = "A"
#   alias {
#     name                   = aws_lb.LoadBalancer.dns_name
#     zone_id                = aws_lb.LoadBalancer.zone_id
#     evaluate_target_health = false
#   }
# }

# resource "aws_route53_record" "DNSRecordByZoneId" {
#   zone_id = "${var.hosted_zone_id}"
#   name    = "${var.hosted_sub_domain}.${var.hosted_zone_name}."
#   type    = "A"

#   alias {
#     name                   = aws_lb.LoadBalancer.dns_name
#     zone_id                = aws_lb.LoadBalancer.zone_id
#     evaluate_target_health = false
#   }
# }
