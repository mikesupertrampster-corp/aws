data "aws_route53_zone" "apex" {
  provider     = aws.root
  name         = var.apex_domain
  private_zone = false
}

resource "aws_route53_zone" "sub" {
  name = "${var.environment}.${data.aws_route53_zone.apex.name}"
}

resource "aws_route53_record" "sub" {
  provider = aws.root
  name     = aws_route53_zone.sub.name
  type     = "NS"
  ttl      = 86400
  records  = aws_route53_zone.sub.name_servers
  zone_id  = data.aws_route53_zone.apex.zone_id
}
