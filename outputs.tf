output "domain_name"            { value = "${var.domain_name}" }
output "primary_public_zone_id" { value = "${aws_route53_zone.primary_public.zone_id}" }