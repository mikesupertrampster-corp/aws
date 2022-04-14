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

resource "aws_security_group" "lb" {
  name   = "alb"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.lb.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.lb.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  type              = "ingress"
}

resource "aws_lb" "test" {
  name               = var.environment
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = module.vpc.public_subnets
}