data "aws_route53_zone" "route53_zone" {
  name         = "${var.domain_name}."
  private_zone = false
}

data "aws_acm_certificate" "cert" {
  domain      = var.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}
