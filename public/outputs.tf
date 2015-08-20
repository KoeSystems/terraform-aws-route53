output "zone_id" { value = "${aws_route53_zone.public.zone_id}" }
output "environment_zone_ids" { value = "${join(",",aws_route53_zone.environment.*.zone_id)}" }
output "environment_names"    { value = "${var.environments}" }