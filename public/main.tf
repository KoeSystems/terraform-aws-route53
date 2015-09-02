# Public Hosted Zone
resource "aws_route53_zone" "public" {
  comment = "Public zone for ${var.domain}"
  name    = "${var.domain}"
}

# Environment domain names
resource "aws_route53_zone" "environment" {
  comment = "Public zone for ${element(split(",", var.environments), count.index)}"
  name    = "${element(split(",", var.environments), count.index)}.${var.domain}"
  count   = "${length(split(",",var.environments))}"
}

# NS Records for environments
resource "aws_route53_record" "NS" {
  zone_id = "${aws_route53_zone.public.zone_id}"
  name    = "${element(split(",", var.environments), count.index)}.${var.domain}"
  type    = "NS"
  ttl     = "30"
  records = [
    "${element(aws_route53_zone.environment.*.name_servers.0,count.index)}",
    "${element(aws_route53_zone.environment.*.name_servers.1,count.index)}",
    "${element(aws_route53_zone.environment.*.name_servers.2,count.index)}",
    "${element(aws_route53_zone.environment.*.name_servers.3,count.index)}"]
  count   = "${length(split(",", var.environments))}"
}