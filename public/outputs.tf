output "domain" { value = "${var.domain}" }
output "zone_id" { value = "${aws_route53_zone.domain.zone_id}" }
output "subdomain_zone_ids" { value = "${join(",",aws_route53_zone.subdomain.*.zone_id)}" }
output "subdomain_names"    { value = "${var.subdomains}" }