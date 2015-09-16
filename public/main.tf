# Delegation names for subdomains
resource "aws_route53_delegation_set" "domain" {
  reference_name = "${var.domain}"
}

resource "aws_route53_delegation_set" "subdomain" {
  count          = "${length(split(",", var.subdomains))}"
  reference_name = "${element(split(",", var.subdomains), count.index)}.${var.domain}"
}

# Domain Hosted Zone
resource "aws_route53_zone" "domain" {
  comment          = "Public zone for ${var.domain}"
  name              = "${var.domain}"
  delegation_set_id = "${aws_route53_delegation_set.domain.id}"
}

# Subdomains Hosted Zones
resource "aws_route53_zone" "subdomain" {
  comment           = "Public zone for ${element(split(",", var.subdomains), count.index)}"
  name              = "${element(split(",", var.subdomains), count.index)}.${var.domain}"
  delegation_set_id = "${element(aws_route53_delegation_set.domain.*.id, count.index)}"
  count             = "${length(split(",", var.subdomains))}"
}

# NS Records for environments

resource "aws_route53_record" "NS" {
  zone_id = "${aws_route53_zone.domain.zone_id}"
  #name    = "${element(split(",", var.subdomains), count.index)}.${var.domain}"
  name    = "${element(aws_route53_zone.subdomain.*.name, count.index)}"
  type    = "NS"
  ttl     = "30"
  records = [
    "${element(aws_route53_delegation_set.subdomain.*.name_servers.0,count.index)}",
    "${element(aws_route53_delegation_set.subdomain.*.name_servers.1,count.index)}",
    "${element(aws_route53_delegation_set.subdomain.*.name_servers.2,count.index)}",
    "${element(aws_route53_delegation_set.subdomain.*.name_servers.3,count.index)}"]
  count   = "${length(split(",", var.subdomains))}"
}
