output "zone_ids" { value = "${join(",", aws_route53_zone.internal.*.zone_id)}" }
output "environments_names" { value = "${var.environments}" }