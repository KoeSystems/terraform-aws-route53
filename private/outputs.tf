output "zone_ids" { value = "${join(",", aws_route53_zone.internal.*.zone_id)}" }
output "subdomain_names" { value = "${var.subdomains}" }