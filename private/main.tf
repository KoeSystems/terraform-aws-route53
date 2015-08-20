# Internal Hosted Zone for each environment
resource "aws_route53_zone" "internal" {
  comment = "Internal zone for ${element(split(",", var.environments), count.index)} in ${var.region}"
  name    = "${element(split(",", var.environments), count.index)}.${var.region}.${var.domain}"
  vpc_id  = "${element(split(",", var.vpc_ids), count.index)}"
  count   = "${length(split(",", var.environments))}"
}